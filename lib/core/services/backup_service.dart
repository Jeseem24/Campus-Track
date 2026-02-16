import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/database/database_helper.dart';

class BackupService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Tables in dependency order (Parent -> Child)
  static const _tables = [
    'semesters',
    'subjects',
    'academic_days',
    'timetable',
    'attendance',
    'tasks',
    'exams',
    'academic_results',
  ];

  Future<void> exportData() async {
    final Map<String, dynamic> backupData = {};
    backupData['version'] = 1;
    backupData['timestamp'] = DateTime.now().toIso8601String();

    // 1. Read all tables
    for (final table in _tables) {
      final data = await _dbHelper.queryAll(table);
      backupData[table] = data;
    }

    // 2. Convert to JSON
    final jsonString = jsonEncode(backupData);

    // 3. Write to temp file
    final tempDir = await getTemporaryDirectory();
    final fileName = 'campustrack_backup_${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsString(jsonString);

    // 4. Share
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'CampusTrack Backup Data',
    );
  }

  Future<bool> importData() async {
    try {
      // 1. Pick File
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        return false; // User canceled
      }

      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final Map<String, dynamic> backupData = jsonDecode(jsonString);

      if (backupData.isEmpty) throw Exception("Empty backup file");

      // 2. Clear Database & Insert
      final db = await _dbHelper.database;
      
      await db.transaction((txn) async {
        // Disable Foreign Keys temporarily if needed (though usually off by default)
        // await txn.execute('PRAGMA foreign_keys = OFF');

        // Delete all existing data (Reverse order)
        for (final table in _tables.reversed) {
          await txn.delete(table);
        }

        // Insert new data (Forward order)
        for (final table in _tables) {
          final List? rows = backupData[table];
          if (rows != null) {
            for (final row in rows) {
              await txn.insert(table, row);
            }
          }
        }
      });

      return true;
    } catch (e) {
      print("Restore Error: $e");
      return false; // Failed
    }
  }
}
