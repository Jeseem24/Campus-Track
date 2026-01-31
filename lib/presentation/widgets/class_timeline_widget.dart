import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/today_classes_provider.dart';
import '../providers/attendance_controller.dart';
import '../../domain/entities/subject.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/providers/all_subjects_provider.dart';
import '../../domain/repositories/attendance_repository.dart';

class ClassTimelineWidget extends ConsumerWidget {
  final List<TimetableSlot> slots;
  final bool isReadOnly;
  final int dateEpoch;

  const ClassTimelineWidget({
    super.key, 
    required this.slots, 
    required this.dateEpoch,
    this.isReadOnly = false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch specific date's attendance
    final attendanceMap = ref.watch(attendanceControllerProvider(dateEpoch)).valueOrNull ?? {};
    final allSubjectsAsync = ref.watch(allSubjectsProvider); 

    if (slots.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(16), child: Text("No classes scheduled! 🎉")));
        
    // Wait for subjects to be ready for lookup
    final allSubjects = allSubjectsAsync.valueOrNull ?? [];

    return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: slots.length,
          separatorBuilder: (c, i) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final slot = slots[index];
            final attendanceLog = attendanceMap[slot.slotIndex];
            final status = attendanceLog?.status;

            // Determine Effective Subject (Scheduled vs Swapped)
            Subject? displaySubject = slot.subject;
            bool isSwapped = false;

            if (attendanceLog != null && attendanceLog.subjectId != slot.subject?.id) {
              // Try to find the substituted subject
              try {
                displaySubject = allSubjects.firstWhere((s) => s.id == attendanceLog.subjectId);
                isSwapped = true;
              } catch (_) {
                // Fallback if not found
              }
            }

            final isFree = displaySubject == null;
            
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isFree ? Colors.grey.shade200 : Color(displaySubject!.color),
                    child: Text(
                      "${slot.slotIndex}",
                      style: TextStyle(
                        color: isFree ? Colors.black54 : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        isFree ? "Free Period" : displaySubject.name,
                        style: TextStyle(
                          fontWeight: isFree ? FontWeight.normal : FontWeight.bold,
                          color: isFree ? Colors.grey : Colors.black87,
                        ),
                      ),
                      if (isSwapped) 
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.swap_horiz, size: 16, color: Colors.blueGrey),
                        ),
                    ],
                  ),
                  subtitle: Text("${slot.timeRange} ${displaySubject != null && displaySubject.code != null ? '• ${displaySubject.code}' : ''}"),
                  trailing: isFree 
                    ? null 
                    : _AttendanceStatusBadge(status: status),
                ),
                if (!isFree)
                  Row(
                    children: [
                      /* Expanded Actions */
                      if (!isReadOnly)
                        Expanded(
                          child: _AttendanceActions(
                            status: status,
                            onTap: (newStatus) {
                              ref.read(attendanceControllerProvider(dateEpoch).notifier).mark(
                                slot.slotIndex, 
                                displaySubject!.id!, 
                                newStatus
                              );
                            },
                          ),
                        ),
                      /* Swap Button */
                      if (!isReadOnly)
                        IconButton(
                          icon: const Icon(Icons.swap_horiz, color: Colors.blueGrey),
                          tooltip: "Swap Subject",
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (c) => _SwapSubjectDialog(
                                slotIndex: slot.slotIndex, 
                                currentSubject: slot.subject!,
                                dateEpoch: dateEpoch,
                              )
                            );
                          },
                        ),
                      const SizedBox(width: 8),
                    ],
                  ),
              ],
            );
          },
    );
  }
}

class _AttendanceStatusBadge extends StatelessWidget {
  final String? status;
  const _AttendanceStatusBadge({this.status});

  @override
  Widget build(BuildContext context) {
    if (status == null) return const SizedBox.shrink();
    
    Color color;
    String text;
    switch(status) {
      case 'PRESENT': color = Colors.green; text = "P"; break;
      case 'ABSENT': color = Colors.red; text = "A"; break;
      case 'OD': color = Colors.orange; text = "OD"; break;
      case 'CANCELLED': color = Colors.grey; text = "OFF"; break;
      default: return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}

class _AttendanceActions extends StatelessWidget {
  final String? status;
  final Function(String) onTap;

  const _AttendanceActions({required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 72, bottom: 8, right: 16),
      child: Row(
        children: [
          _ActionButton(
            label: "P", 
            color: Colors.green, 
            isSelected: status == 'PRESENT',
            onTap: () => onTap('PRESENT'),
          ),
          const SizedBox(width: 8),
          _ActionButton(
            label: "A", 
            color: Colors.red, 
            isSelected: status == 'ABSENT',
            onTap: () => onTap('ABSENT'),
          ),
          const SizedBox(width: 8),
          _ActionButton(
            label: "OD", 
            color: Colors.orange, 
            isSelected: status == 'OD',
            onTap: () => onTap('OD'),
          ),
          const SizedBox(width: 8),
          _ActionButton(
            label: "OFF", 
            color: Colors.grey, 
            isSelected: status == 'CANCELLED',
            onTap: () => onTap('CANCELLED'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label, 
    required this.color, 
    required this.isSelected, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _SwapSubjectDialog extends ConsumerWidget {
  final int slotIndex;
  final Subject currentSubject;
  final int dateEpoch;

  const _SwapSubjectDialog({
    required this.slotIndex, 
    required this.currentSubject,
    required this.dateEpoch
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(subjectRepositoryProvider);
    
    return AlertDialog(
      title: Text("Swap Period ${slotIndex}"),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder(
          future: repo.getSubjectsForSemester(currentSubject.semesterId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            final subjects = snapshot.data as List<Subject>;
            
            return ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final sub = subjects[index];
                if (sub.id == currentSubject.id) return const SizedBox.shrink(); // Skip current

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(sub.color),
                    radius: 12,
                  ),
                  title: Text(sub.name),
                  subtitle: Text(sub.code ?? ""),
                  onTap: () {
                     ref.read(attendanceControllerProvider(dateEpoch).notifier).mark(
                        slotIndex, 
                        sub.id!, 
                        'PRESENT' // Default to Present if swapping
                     );
                     Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
      ],
    );
  }
}
