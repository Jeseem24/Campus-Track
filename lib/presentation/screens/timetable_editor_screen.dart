import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/subject.dart';
import '../../data/repositories/timetable_repository_impl.dart';
import '../../presentation/providers/subject_controller.dart';
import '../../domain/providers/attendance_stats_provider.dart';
import '../../domain/providers/today_classes_provider.dart';

class TimetableEditorScreen extends ConsumerStatefulWidget {
  const TimetableEditorScreen({super.key});

  @override
  ConsumerState<TimetableEditorScreen> createState() => _TimetableEditorScreenState();
}

class _TimetableEditorScreenState extends ConsumerState<TimetableEditorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Day Order -> Slot Index -> Subject ID
  Map<int, Map<int, int>> _timetable = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadTimetable();
  }

  Future<void> _loadTimetable() async {
    setState(() => _isLoading = true);
    final repo = ref.read(timetableRepositoryProvider);
    final newState = <int, Map<int, int>>{};

    for (int i = 1; i <= 6; i++) {
       newState[i] = await repo.getTimetableForDay(i);
    }

    if (mounted) {
      setState(() {
        _timetable = newState;
        _isLoading = false;
      });
    }
  }

  Future<void> _assignSlot(int dayOrder, int slotIndex, Subject? subject) async {
    final repo = ref.read(timetableRepositoryProvider);
    
    if (subject == null) {
      // Clear Slot
      await repo.clearSlot(dayOrder, slotIndex);
    } else {
      // Assign Slot
      await repo.assignSlot(dayOrder, slotIndex, subject.id!);
    }
    
    // Update Local State
    final currentDay = _timetable[dayOrder] ?? {};
    if (subject == null) {
      currentDay.remove(slotIndex);
    } else {
      currentDay[slotIndex] = subject.id!;
    }
    
    setState(() {
      _timetable[dayOrder] = currentDay;
    });

    // Invalidate caches to update UI elsewhere
    ref.invalidate(attendanceStatsProvider);
    ref.invalidate(classesForDateProvider);
  }

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Timetable"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: List.generate(6, (i) => Tab(text: "Order ${i + 1}")),
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: List.generate(6, (i) {
              final dayOrder = i + 1;
              return _buildDayEditor(dayOrder, subjectsAsync);
            }),
          ),
    );
  }

  Widget _buildDayEditor(int dayOrder, AsyncValue<List<Subject>> subjectsAsync) {
    final slots = _timetable[dayOrder] ?? {};
    final subjects = subjectsAsync.valueOrNull ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        final slotIndex = index + 1;
        final subjectId = slots[slotIndex];
        
        Subject? assignedSubject;
        if (subjectId != null) {
          try {
            assignedSubject = subjects.firstWhere((s) => s.id == subjectId);
          } catch (_) {}
        }
        
        return Card(
           margin: const EdgeInsets.only(bottom: 12),
           elevation: 0,
           color: assignedSubject != null ? Color(assignedSubject.color).withOpacity(0.1) : Colors.grey.shade50,
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: assignedSubject != null 
                 ? BorderSide(color: Color(assignedSubject.color).withOpacity(0.5)) 
                 : BorderSide.none
           ),
           child: ListTile(
             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
             leading: CircleAvatar(
               backgroundColor: assignedSubject != null ? Color(assignedSubject.color) : Colors.grey.shade300,
               child: Text(
                 "$slotIndex",
                 style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)
               ),
             ),
             title: Text(
               assignedSubject?.name ?? "Free Period",
               style: GoogleFonts.poppins(
                 fontWeight: FontWeight.w600,
                 color: assignedSubject != null ? Colors.black87 : Colors.grey.shade500
               ),
             ),
             subtitle: Text(assignedSubject?.code ?? "Tap to assign subject"),
             trailing: const Icon(Icons.edit, size: 20),
             onTap: () => _showSubjectPicker(dayOrder, slotIndex, subjects),
           ),
        );
      },
    );
  }

  void _showSubjectPicker(int dayOrder, int slotIndex, List<Subject> subjects) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Text("Select Subject for Slot $slotIndex", style: Theme.of(context).textTheme.titleMedium),
               const SizedBox(height: 16),
               Expanded(
                 child: ListView(
                   children: [
                     ListTile(
                       leading: const Icon(Icons.block, color: Colors.grey),
                       title: const Text("Free Period"),
                       onTap: () {
                         Navigator.pop(context);
                         _assignSlot(dayOrder, slotIndex, null);
                       },
                     ),
                     const Divider(),
                     ...subjects.map((s) => ListTile(
                       leading: CircleAvatar(
                          backgroundColor: Color(s.color),
                          radius: 12,
                       ),
                       title: Text(s.name),
                       subtitle: Text(s.code ?? ""),
                       onTap: () {
                         Navigator.pop(context);
                         _assignSlot(dayOrder, slotIndex, s);
                       },
                     ))
                   ],
                 ),
               ),
             ],
          ),
        );
      }
    );
  }
}
