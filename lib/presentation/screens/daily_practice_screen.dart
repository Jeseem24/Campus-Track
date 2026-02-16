import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/daily_practice_provider.dart';
import '../../domain/entities/daily_practice_log.dart';

class DailyPracticeScreen extends ConsumerStatefulWidget {
  const DailyPracticeScreen({super.key});

  @override
  ConsumerState<DailyPracticeScreen> createState() => _DailyPracticeScreenState();
}

class _DailyPracticeScreenState extends ConsumerState<DailyPracticeScreen> {
  final TextEditingController _jsController = TextEditingController();
  final TextEditingController _dsaController = TextEditingController();
  final TextEditingController _aptitudeController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _jsController.dispose();
    _dsaController.dispose();
    _aptitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todayLog = ref.watch(todayPracticeLogProvider);
    final allLogs = ref.watch(dailyPracticeLogsProvider);

    // Sync controllers only if empty to allow user typing without overwrite loop
    if (_jsController.text.isEmpty && todayLog.jsProblem != null) {
      _jsController.text = todayLog.jsProblem!;
    }
    if (_dsaController.text.isEmpty && todayLog.dsaProblem != null) {
      _dsaController.text = todayLog.dsaProblem!;
    }
    if (_aptitudeController.text.isEmpty && todayLog.aptitudeTopic != null) {
      _aptitudeController.text = todayLog.aptitudeTopic!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Growth 🌱'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              
              _buildInputCard(
                title: 'JavaScript (LeetCode)',
                icon: Icons.javascript,
                color: Colors.yellow.shade700,
                controller: _jsController,
                hint: 'e.g., Two Sum, Closure...',
                onSave: (val) {
                   ref.read(dailyPracticeLogsProvider.notifier).updateJsProblem(val);
                   if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved JS Progress!')));
                   }
                },
              ),
              
              const SizedBox(height: 12),
              
              _buildInputCard(
                title: 'DSA (HackerRank)',
                icon: Icons.code,
                color: Colors.blueAccent,
                controller: _dsaController,
                hint: 'e.g., Array Manipulation...',
                onSave: (val) {
                  ref.read(dailyPracticeLogsProvider.notifier).updateDsaProblem(val);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved DSA Progress!')));
                  }
                },
              ),
              
              const SizedBox(height: 12),
              
              _buildInputCard(
                title: 'Aptitude Practice',
                icon: Icons.calculate,
                color: Colors.green,
                controller: _aptitudeController,
                hint: 'e.g., Time & Work, Percentage...',
                onSave: (val) {
                  ref.read(dailyPracticeLogsProvider.notifier).updateAptitudeTopic(val);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved Aptitude Progress!')));
                  }
                },
              ),

              const SizedBox(height: 30),
              
              const Text(
                "Consistency Chart",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              _buildCalendar(allLogs),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMMM d').format(DateTime.now()),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Today's Focus",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.local_fire_department,
            color: Colors.orange,
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard({
    required String title,
    required IconData icon,
    required Color color,
    required TextEditingController controller,
    required String hint,
    required Function(String) onSave,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => onSave(controller.text),
                  icon: const Icon(Icons.check),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(Map<DateTime, DailyPracticeLog> logs) {
    return Card(
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; 
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            // Check if we have a log for this day
            final normalizedDate = DateTime(date.year, date.month, date.day);
            final log = logs[normalizedDate];
            
            if (log != null) {
               final bool isComplete = log.isComplete;
               final bool hasContent = (log.jsProblem != null && log.jsProblem!.isNotEmpty) || 
                                       (log.dsaProblem != null && log.dsaProblem!.isNotEmpty) || 
                                       (log.aptitudeTopic != null && log.aptitudeTopic!.isNotEmpty);
                                       
               if (hasContent) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isComplete ? Colors.green : Colors.orange, // Simple logic: Green if any content for now, or refine 'isComplete'
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
               }
            }
            return null;
          },
        ),
      ),
    );
  }
}
