import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/active_semester_provider.dart';
import '../../presentation/providers/day_order_provider.dart';
import '../../domain/providers/seed_provider.dart';
import '../../domain/providers/today_classes_provider.dart';
import '../../data/repositories/day_repository_impl.dart'; // Verified Import for provider
import '../widgets/day_card.dart';
import '../widgets/task_list_widget.dart';
import '../widgets/class_timeline_widget.dart';
import '../widgets/attendance_dashboard.dart';
import '../widgets/add_task_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _viewingTomorrow = false;

  @override
  Widget build(BuildContext context) {
    // Determine Date
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final targetDate = _viewingTomorrow ? tomorrow : today;

    // Fetch Day Info for Header (Day Card)
    final dayRepo = ref.watch(dayRepositoryProvider);
    // Note: We use FutureBuilder below for the day card.
    
    final activeSemester = ref.watch(activeSemesterProvider).valueOrNull;

    // Trigger Seeding if we have a semester (Fire and forget, purely side effect)
    if (activeSemester != null) {
      ref.listen(seedDatabaseProvider(activeSemester.id!), (_, __) {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.book), 
            tooltip: "Subjects",
            onPressed: () {
               context.push('/subjects');
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              context.push('/calendar');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _viewingTomorrow ? 'Tomorrow' : 'Today',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: SegmentedButton<bool>(
                      segments: const [
                         ButtonSegment(value: false, label: Text("Today")),
                         ButtonSegment(value: true, label: Text("Tomorrow")),
                      ],
                      selected: {_viewingTomorrow},
                      onSelectionChanged: (val) => setState(() => _viewingTomorrow = val.first),
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              
              // Day Card (Dynamic)
              FutureBuilder(
                future: dayRepo.getDay(targetDate.millisecondsSinceEpoch), // Fixed method name
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                     return const Center(child: LinearProgressIndicator());
                  }
                  if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                  
                  final day = snapshot.data;
                  if (day == null) return const Card(child: Padding(padding: EdgeInsets.all(16), child: Text("Day not generated yet."))); // Startup edge case
                  
                  return DayCard(day: day);
                }
              ),
              
              const SizedBox(height: 16),
              
              // 3. Stats Dashboard (Always Overall Stats? Or only show on Today?)
              // Generally stats are persistent.
              if (!_viewingTomorrow) ...[
                 const AttendanceDashboard(),
                 const SizedBox(height: 16),
              ],

              Text(
                _viewingTomorrow ? "Tomorrow's Schedule" : "Classes",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              
              Card(
                elevation: 0,
                color: Colors.white,
                child: Consumer(
                  builder: (context, ref, _) {
                    final slotsAsync = ref.watch(classesForDateProvider(targetDate.millisecondsSinceEpoch));
                    return slotsAsync.when(
                      data: (slots) => ClassTimelineWidget(
                        slots: slots,
                        dateEpoch: targetDate.millisecondsSinceEpoch,
                        isReadOnly: _viewingTomorrow // Disable marking for tomorrow
                      ),
                      loading: () => const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator())),
                      error: (e, s) => Padding(padding: const EdgeInsets.all(16), child: Text("Error: $e")),
                    );
                  }
                ),
              ),

              const SizedBox(height: 24),
              // Tasks (Always show Pending Tasks? Or sort by day?)
              // User request: "Pending tasks" overflow fixed.
              if (!_viewingTomorrow) ...[
                 const TaskListWidget(),
                 const SizedBox(height: 80), // Space for FAB
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: !_viewingTomorrow ? FloatingActionButton(
        onPressed: () {
           showDialog(
             context: context, 
             builder: (context) => const AddTaskDialog()
           );
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}
