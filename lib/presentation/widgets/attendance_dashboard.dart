import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/providers/attendance_stats_provider.dart';
import '../providers/attendance_controller.dart';

class AttendanceDashboard extends ConsumerWidget {
  const AttendanceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(attendanceStatsProvider);

    return statsAsync.when(
      data: (stats) {
        if (stats.isEmpty) return const SizedBox.shrink();

        // Calculate Overall
        int totalClasses = 0;
        int attendedClasses = 0;
        for (var s in stats) {
          totalClasses += s.total;
          attendedClasses += (s.present + s.od);
        }
        final double overall = totalClasses == 0 ? 100 : (attendedClasses / totalClasses) * 100;
        
        return Column(
          children: [
            // Minimalist Overall Card
            Container(
              margin: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 4))
                ]
              ),
              child: Row(
                children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Overall Attendance", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600)),
                         const SizedBox(height: 8),
                         Text(
                           "${overall.toStringAsFixed(1)}%", 
                           style: GoogleFonts.poppins(
                             fontSize: 42, 
                             fontWeight: FontWeight.bold,
                             color: overall >= 75 ? const Color(0xFF2D3436) : const Color(0xFFD63031),
                             height: 1.0
                           )
                         ),
                         const SizedBox(height: 8),
                         Text(
                           overall >= 75 ? "You're doing great! 🌟" : "Attendance is low ⚠️",
                           style: TextStyle(
                             color: overall >= 75 ? Colors.green : Colors.red,
                             fontWeight: FontWeight.w500
                           ),
                         )
                       ],
                     ),
                   ),
                   // Donut Chart Placeholder (Simple Circular Progress for now)
                   Stack(
                     alignment: Alignment.center,
                     children: [
                       SizedBox(
                         width: 80, height: 80,
                         child: CircularProgressIndicator(
                           value: overall / 100,
                           strokeWidth: 8,
                           backgroundColor: Colors.grey.shade100,
                           color: overall >= 75 ? const Color(0xFF6C5CE7) : const Color(0xFFD63031),
                           strokeCap: StrokeCap.round,
                         ),
                       ),
                       Text(
                         "${attendedClasses}/${totalClasses}",
                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                       )
                     ],
                   )
                ],
              ),
            ),
            
            // Minimal Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                        // Confirm
                        showDialog(
                          context: context, 
                          builder: (c) => AlertDialog(
                            title: const Text("Mark All Absent?"),
                            content: const Text("This will mark you as ABSENT for all classes today."),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancel")),
                              TextButton(
                                onPressed: () async {
                                  // Mark attendance for Today
                                  final now = DateTime.now();
                                  final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
                                  
                                  try {
                                    await ref.read(attendanceControllerProvider(today).notifier).markAll('ABSENT');
                                    if (context.mounted) {
                                      Navigator.pop(c);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Marked all classes as Absent"), backgroundColor: Colors.red)
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) Navigator.pop(c);
                                  }
                                }, 
                                child: const Text("Confirm", style: TextStyle(color: Colors.red))
                              ),
                            ],
                          )
                        );
                  },
                  icon: const Icon(Icons.free_breakfast_outlined, size: 18),
                  label: const Text("Not going today? Mark all absent"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade500,
                    padding: const EdgeInsets.symmetric(vertical: 12)
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }
}
