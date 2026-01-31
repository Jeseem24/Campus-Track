import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/academic_day.dart';
import '../../data/repositories/day_repository_impl.dart';
import '../providers/calendar_provider.dart';
import '../../domain/providers/active_semester_provider.dart';
import '../widgets/day_editor_dialog.dart';
import '../widgets/day_editor_dialog.dart';
import '../widgets/past_attendance_dialog.dart';
import '../providers/monthly_attendance_provider.dart';
import '../../core/theme/modern_theme.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    // Normalize to first of month to ensure cache hits when changing days in same month
    final monthKey = DateTime(_focusedDay.year, _focusedDay.month);
    final calendarStateAsync = ref.watch(monthCalendarProvider(monthKey));
    final attendanceStatusAsync = ref.watch(monthlyAttendanceStatusProvider(monthKey));
    
    final attendanceMap = attendanceStatusAsync.valueOrNull ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Calendar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Compresses to content
          children: [
            calendarStateAsync.when(
              data: (days) {
                // Convert list to Map for TableCalendar fast lookup
                final dayMap = {
                  for (var d in days) 
                    DateTime(d.date.year, d.date.month, d.date.day): d
                };
  
                return TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  rowHeight: 60, // Increased to fit Day Number + Day Order
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) async {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    
                    // Normalize
                    final dateKey = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                    var currentState = dayMap[dateKey];
                    
                    // Auto-Generate if missing
                    if (currentState == null) {
                       // 1. Check if allowed (within reasonable range, e.g. current semester?)
                       // For now, allow any date user clicks to be generated for the active semester.
                       final semester = await ref.read(activeSemesterProvider.future);
                       if (semester != null) {
                          // Check Sunday
                          final isSunday = dateKey.weekday == DateTime.sunday;
                          
                          // Smart Order Inference
                          int? newOrder;
                          if (!isSunday) {
                            // Try yesterday
                            final yesterday = dateKey.subtract(const Duration(days: 1));
                            final yesterdayState = dayMap[yesterday];
                            if (yesterdayState != null && !yesterdayState.isHoliday && yesterdayState.dayOrder != null) {
                               newOrder = (yesterdayState.dayOrder! % 6) + 1;
                            } else {
                               newOrder = 1; // Default
                            }
                          }
                          
                          final newDay = AcademicDay(
                            dateEpoch: dateKey.millisecondsSinceEpoch,
                            semesterId: semester.id!,
                            dayOrder: isSunday ? null : newOrder,
                            isHoliday: isSunday,
                            isManualOverride: false
                          );
                          
                          // Save
                          final dayRepo = ref.read(dayRepositoryProvider);
                          await dayRepo.saveDay(newDay);
                          
                          // Refresh to show it
                          ref.invalidate(monthCalendarProvider);
                          
                          // Convert to CalendarDayState for the dialog
                          currentState = CalendarDayState(
                             date: dateKey,
                             dayOrder: newDay.dayOrder,
                             isHoliday: newDay.isHoliday,
                             isManualOverride: newDay.isManualOverride
                          );
                       }
                    }
                    
                    if (currentState != null && context.mounted) {
                      _showDayDetails(context, currentState);
                    }
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      return _buildDayCell(context, day, dayMap, attendanceMap);
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return _buildDayCell(context, day, dayMap, attendanceMap);
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return _buildDayCell(context, day, dayMap, attendanceMap, isSelected: true);
                    },
                    outsideBuilder: (context, day, focusedDay) {
                      return const SizedBox.shrink(); 
                    },
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                );
              },
              loading: () => const SizedBox(height: 300, child: Center(child: CircularProgressIndicator())),
              error: (err, stack) => SizedBox(height: 300, child: Center(child: Text("Error: $err"))),
            ),
            
            const SizedBox(height: 16),
            // Legend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 12,
                runSpacing: 8,
                children: [
                  _buildLegendItem(context, const Color(0xFFE3FCEF), "Present"),
                  _buildLegendItem(context, const Color(0xFFFFDEDE), "Absent"),
                  _buildLegendItem(context, Colors.grey.shade100, "Holiday"),
                  _buildLegendItem(context, const Color(0xFFFFF4D9), "Partial"),
                ],
              ),
            ),
            const SizedBox(height: 40), // Bottom Buffer
          ],
        ),
      ),
    );
  }

  Widget _buildDayCell(BuildContext context, DateTime day, Map<DateTime, CalendarDayState> dayMap, Map<int, DayAttendanceStatus> attendanceMap, {bool isSelected = false}) {
    // Normalize to midnight
    final dateKey = DateTime(day.year, day.month, day.day);
    final state = dayMap[dateKey];

    if (state == null) {
      return Center(child: Text("${day.day}", style: GoogleFonts.poppins(color: Colors.grey.shade400)));
    }

    final isToday = isSameDay(day, DateTime.now());
    final isHoliday = state.isHoliday;
    final isOverride = state.isManualOverride;
    final attendanceStatus = attendanceMap[dateKey.millisecondsSinceEpoch] ?? DayAttendanceStatus.none;
    
    // Modern Palette
    Color bgColor = Colors.transparent;
    Color textColor = const Color(0xFF2D3436);
    
    // Status Logic
    if (isSelected) {
      bgColor = const Color(0xFF2D3436);
      textColor = Colors.white;
    } else if (attendanceStatus == DayAttendanceStatus.fullAbsent) {
      bgColor = const Color(0xFFFFDEDE); // Soft Red
      textColor = const Color(0xFFD63031);
    } else if (attendanceStatus == DayAttendanceStatus.fullPresent) {
      bgColor = const Color(0xFFE3FCEF); // Soft Green
      textColor = const Color(0xFF00B894);
    } else if (attendanceStatus == DayAttendanceStatus.partial) {
      bgColor = const Color(0xFFFFF4D9); // Soft Orange
      textColor = const Color(0xFFE17055);
    } else if (isHoliday) {
      bgColor = Colors.grey.shade100;
      textColor = Colors.grey.shade500;
    } else if (state.dayOrder != null) {
      // Future working day
      bgColor = Colors.grey.shade50;
    }

    // Border Logic
    BoxBorder? boxBorder;
    if (isToday) {
      boxBorder = Border.all(color: ModernTheme.secondary, width: 2.5); // Highlight Today
    } else if (isOverride) {
      boxBorder = Border.all(color: Colors.orange.shade200, width: 2);
    }

    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: boxBorder,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${day.day}",
             style: GoogleFonts.poppins(
               fontWeight: FontWeight.bold,
               color: textColor,
               fontSize: 16
             ),
          ),
          if (!isHoliday && state.dayOrder != null && !isSelected) ...[
             const SizedBox(height: 2),
             Text(
               "${state.dayOrder}",
               style: GoogleFonts.poppins(
                 fontSize: 10,
                 fontWeight: FontWeight.w600,
                 color: textColor.withOpacity(0.7)
               )
             )
          ]
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  void _showDayDetails(BuildContext context, CalendarDayState? state) {
    if (state == null) return;
    
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMEEEEd().format(state.date),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                if (state.isHoliday)
                  const Text("Status: Holiday 🏖️")
                else
                  Text("Status: Day Order ${state.dayOrder}"),
                  
                if (state.isManualOverride)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("⚠️ This is a Manual Override", style: TextStyle(color: Colors.orange)),
                  ),
                  
                const SizedBox(height: 24),
                const Text("Edit Options:"), // Removed "Coming Soon"
                const SizedBox(height: 8),
                 SizedBox(
                   width: double.infinity,
                   child: OutlinedButton.icon(
                     icon: const Icon(Icons.settings),
                     label: const Text("Edit Day Properties (Holiday / Order)"),
                     onPressed: () async {
                        Navigator.pop(context); // Close sheet first
                        
                        final semester = await ref.read(activeSemesterProvider.future);
                        if (semester != null && context.mounted) {
                          final changed = await showDialog<bool>(
                            context: context,
                            builder: (_) => DayEditorDialog(
                              date: state.date,
                              semesterId: semester.id!,
                              currentState: state,
                            ),
                          );
                          
                          if (changed == true) {
                            ref.invalidate(monthCalendarProvider);
                          }
                        }
                     },
                   ),
                 ),
                
                if (!state.isHoliday) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // Close sheet
                        showDialog(
                          context: context, 
                          builder: (c) => PastAttendanceDialog(date: state.date)
                        );
                      }, 
                      icon: const Icon(Icons.edit_calendar), 
                      label: const Text("Edit Attendance"),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
