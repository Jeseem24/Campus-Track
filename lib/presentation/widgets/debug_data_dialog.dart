import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/database/database_helper.dart';
import '../../domain/providers/attendance_stats_provider.dart';
import '../../domain/providers/today_classes_provider.dart'; // New Import

class DebugDataDialog extends ConsumerStatefulWidget {
  const DebugDataDialog({super.key});

  @override
  ConsumerState<DebugDataDialog> createState() => _DebugDataDialogState();
}

class _DebugDataDialogState extends ConsumerState<DebugDataDialog> {
  List<Map<String, dynamic>> _days = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDays();
  }

  Future<void> _loadDays() async {
    final db = await DatabaseHelper.instance.database;
    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59).millisecondsSinceEpoch;
    
    final res = await db.query(
      'academic_days', 
      where: 'date_epoch <= ? AND is_holiday = 0 AND day_order IS NOT NULL',
      whereArgs: [endOfToday],
      orderBy: 'date_epoch DESC'
    );
    
    if (mounted) {
      setState(() {
        _days = List.from(res);
        _loading = false;
      });
    }
  }

  Future<void> _deleteDay(int dateEpoch) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('academic_days', where: 'date_epoch = ?', whereArgs: [dateEpoch]);
    await _loadDays();
    ref.invalidate(attendanceStatsProvider); // Refresh main stats
  }
  
  Future<void> _applyNewTimetable() async {
     final db = await DatabaseHelper.instance.database;
     // Timetable Data
     final timetable = {
       1: ['IT22611', 'HS22601', 'CS22641', 'CE22681', 'CS22601', 'CS22601', 'IT22611', 'IT22601'],
       2: ['HS22601', 'CS22601', 'SD22601', 'SD22601', 'CE22681', 'LIB06', 'HS22601', 'CS22641'],
       3: ['IT22611', 'IT22611', 'IT22611', 'IT22611', 'IT22601', 'IT22601', 'HS22601', 'CS22601'],
       4: ['CS22641', 'CS22641', 'CS22641', 'CS22641', 'SD22601', 'SD22601', 'IT22611', 'IT22611'],
       5: ['IT22601', 'IT22601', 'IT22601', 'IT22601', 'HS22601', 'CE22681', 'CE22681', 'CS22601'],
       6: ['CE22681', 'CE22681', 'IT22601', 'HS22601', 'CS22601', 'CS22601', 'CS22641', 'MENTO6'],
     };
     
     // Resolve IDs (Quick lookup based on code pattern or name if possible, 
     // but safe to assume codes exist from seed).
     
     await db.transaction((txn) async {
       await txn.delete('timetable');
       for (var entry in timetable.entries) {
          final dayOrder = entry.key;
          final codes = entry.value;
          for (int i = 0; i < codes.length; i++) {
             final code = codes[i];
             // Simple Query inside transaction? 
             final subRes = await txn.query('subjects', where: 'code = ?', whereArgs: [code]);
             if (subRes.isNotEmpty) {
               await txn.insert('timetable', {
                  'day_order': dayOrder,
                  'slot_index': i + 1,
                  'subject_id': subRes.first['id']
               });
             }
          }
       }
     });
     
     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New Timetable Applied!")));
       ref.invalidate(attendanceStatsProvider);
       ref.invalidate(classesForDateProvider); // Force UI Refresh
     }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Debug & Fix Data"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             ElevatedButton(
               onPressed: _applyNewTimetable, 
               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
               child: const Text("Update to New Timetable")
             ),
             const Divider(),
             const Text("Active Working Days (Past):", style: TextStyle(fontWeight: FontWeight.bold)),
             
             _loading 
               ? const LinearProgressIndicator()
               : Expanded(
                   child: ListView.builder(
                     shrinkWrap: true,
                     itemCount: _days.length,
                     itemBuilder: (c, i) {
                       final d = _days[i];
                       final date = DateTime.fromMillisecondsSinceEpoch(d['date_epoch']);
                       return ListTile(
                         dense: true,
                         title: Text("${DateFormat('MMM d (EEE)').format(date)}"),
                         subtitle: Text("Day Order: ${d['day_order']}"),
                         trailing: IconButton(
                           icon: const Icon(Icons.delete, color: Colors.red),
                           onPressed: () => _deleteDay(d['date_epoch']), // FIXED HERE
                         ),
                       );
                     },
                   ),
                 )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))
      ],
    );
  }
}
