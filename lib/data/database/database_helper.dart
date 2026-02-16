import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const int _version = 7;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('campus_track.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // 1. Semesters Table
    await db.execute('''
      CREATE TABLE semesters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        start_date INTEGER NOT NULL,
        end_date INTEGER NOT NULL,
        is_active INTEGER NOT NULL
      )
    ''');

    // 2. Academic Days Table (The source of truth)
    await db.execute('''
      CREATE TABLE academic_days (
        date_epoch INTEGER PRIMARY KEY,
        semester_id INTEGER NOT NULL,
        is_holiday INTEGER NOT NULL,
        day_order INTEGER, 
        is_manual_override INTEGER NOT NULL,
        affects_future INTEGER NOT NULL,
        note TEXT,
        FOREIGN KEY (semester_id) REFERENCES semesters (id) ON DELETE CASCADE
      )
    ''');

    // 3. Subjects Table
    await db.execute('''
      CREATE TABLE subjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        code TEXT,
        color INTEGER NOT NULL DEFAULT 4280391411, -- Default Color
        credits INTEGER NOT NULL DEFAULT 3,
        semester_id INTEGER NOT NULL,
        FOREIGN KEY (semester_id) REFERENCES semesters (id) ON DELETE CASCADE
      )
    ''');

    // 4. Timetable Table (Maps Day Order -> Slots)
    await db.execute('''
      CREATE TABLE timetable (
        day_order INTEGER NOT NULL,
        slot_index INTEGER NOT NULL,
        subject_id INTEGER NOT NULL,
        PRIMARY KEY (day_order, slot_index),
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
      )
    ''');

    // 5. Attendance Table
    await db.execute('''
      CREATE TABLE attendance (
        date_epoch INTEGER NOT NULL,
        slot_index INTEGER NOT NULL,
        subject_id INTEGER NOT NULL,
        status TEXT NOT NULL,
        PRIMARY KEY (date_epoch, slot_index),
        FOREIGN KEY (date_epoch) REFERENCES academic_days (date_epoch) ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
      )
    ''');

    // 6. Tasks Table
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        due_date INTEGER,
        is_completed INTEGER NOT NULL,
        subject_id INTEGER,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE SET NULL
      )
    ''');
    
    // 7. Exams Table
    await db.execute('''
      CREATE TABLE exams (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        date INTEGER NOT NULL,
        total_marks REAL NOT NULL,
        obtained_marks REAL,
        FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
      )
    ''');

    // 8. Academic Results (CGPA Tracker)
    await db.execute('''
      CREATE TABLE academic_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        semester_name TEXT NOT NULL,
        gpa REAL NOT NULL,
        total_credits REAL NOT NULL
      )
    ''');

    // 9. Create Indices for Performance
    await db.execute('CREATE INDEX idx_academic_days_semester ON academic_days(semester_id)');
    await db.execute('CREATE INDEX idx_attendance_date ON attendance(date_epoch)');
    await db.execute('CREATE INDEX idx_timetable_day_order ON timetable(day_order)');
    await db.execute('CREATE INDEX idx_subjects_semester ON subjects(semester_id)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Simple migration: Drop and recreate (Since we are in early dev)
      await db.execute('DROP TABLE IF EXISTS attendance');
      await db.execute('DROP TABLE IF EXISTS timetable');
      await db.execute('DROP TABLE IF EXISTS tasks');
      await db.execute('DROP TABLE IF EXISTS subjects');
      await db.execute('DROP TABLE IF EXISTS academic_days');
      await db.execute('DROP TABLE IF EXISTS semesters');
      await _createDB(db, newVersion);
    } else if (oldVersion < 3) {
       // Version 3: Attendance Table Schema Change
       await db.execute('DROP TABLE IF EXISTS attendance');
        await db.execute('''
          CREATE TABLE attendance (
            date_epoch INTEGER NOT NULL,
            slot_index INTEGER NOT NULL,
            subject_id INTEGER NOT NULL,
            status TEXT NOT NULL,
            PRIMARY KEY (date_epoch, slot_index),
            FOREIGN KEY (date_epoch) REFERENCES academic_days (date_epoch) ON DELETE CASCADE,
            FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
          )
        ''');
    } 
    
    if (oldVersion < 4) {
      // Version 4: Add Exams Table
      await db.execute('''
        CREATE TABLE exams (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          subject_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          date INTEGER NOT NULL,
          total_marks REAL NOT NULL,
          obtained_marks REAL,
          FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
        )
      ''');
    }
    
    if (oldVersion < 5) {
      // Version 5: Academic Results
      await db.execute('''
        CREATE TABLE academic_results (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          semester_name TEXT NOT NULL,
          gpa REAL NOT NULL,
          total_credits REAL NOT NULL
        )
      ''');
    }
    
    if (oldVersion < 6) {
      // Version 6: Retry Academic Results creation if failed or for new users on v5
      await db.execute('DROP TABLE IF EXISTS academic_results');
      await db.execute('''
        CREATE TABLE academic_results (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          semester_name TEXT NOT NULL,
          gpa REAL NOT NULL,
          total_credits REAL NOT NULL
        )
      ''');
    }
    
    if (oldVersion < 7) {
      // Version 7: Add Performance Indices
      await db.execute('CREATE INDEX IF NOT EXISTS idx_academic_days_semester ON academic_days(semester_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_attendance_date ON attendance(date_epoch)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_timetable_day_order ON timetable(day_order)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_subjects_semester ON subjects(semester_id)');
    }
  }

  // --- CRUD Helpers ---
  
  // Generic Insert
  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.insert(table, values);
  }

  // Generic Query
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  // Generic Search
  Future<List<Map<String, dynamic>>> queryBy(String table, String where, List<dynamic> args) async {
    final db = await instance.database;
    return await db.query(table, where: where, whereArgs: args);
  }

  // Close
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
