# Graph Report - campus_track  (2026-08-28)

## Corpus Check
- 168 files · ~70,671 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1228 nodes · 1762 edges · 94 communities (76 shown, 18 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Module 0
- Module 1
- Module 2
- Module 3
- Module 4
- Module 5
- Module 6
- Module 7
- Module 8
- Module 9
- Module 10
- Module 11
- Module 12
- Module 13
- Module 14
- Module 15
- Module 16
- Module 17
- Module 18
- Module 19
- Module 20
- Module 21
- Module 22
- Module 23
- Module 24
- Module 25
- Module 26
- Module 27
- Module 28
- Module 29
- Module 30
- Module 31
- Module 32
- Module 33
- Module 34
- Module 35
- Module 36
- Module 37
- Module 38
- Module 39
- Module 40
- Module 41
- Module 42
- Module 43
- Module 44
- Module 45
- Module 46
- Module 47
- Module 48
- Module 49
- Module 50
- Module 51
- Module 52
- Module 53
- Module 54
- Module 55
- Module 56
- Module 57
- Module 58
- Module 59
- Module 60
- Module 61
- Module 62
- Module 63
- Module 64
- Module 65
- Module 66
- Module 67
- Module 68
- Module 69
- Module 70
- Module 71
- Module 72
- Module 73
- Module 74
- Module 75
- Module 76
- Module 77
- Module 78
- Module 79
- Module 80
- Module 81
- Module 82
- Module 83
- Module 84
- Module 88
- Module 89
- Module 90
- Module 91
- Module 92
- Module 93

## God Nodes (most connected - your core abstractions)
1. `DatabaseHelper` - 12 edges
2. `AttendanceController` - 6 edges
3. `ClassesForDateRef` - 5 edges
4. `AcademicDayForDateRef` - 5 edges
5. `AttendanceControllerRef` - 5 edges
6. `_AttendanceControllerProviderElement` - 5 edges
7. `MonthCalendarRef` - 5 edges
8. `MonthlyAttendanceStatusRef` - 5 edges
9. `_DailyPracticeScreenState` - 5 edges
10. `build` - 5 edges

## Surprising Connections (you probably didn't know these)
- `AttendanceRepositoryImpl` --implements--> `AttendanceRepository`  [EXTRACTED]
  lib/data/repositories/attendance_repository_impl.dart → lib/domain/repositories/attendance_repository.dart
- `DayRepositoryImpl` --implements--> `DayRepository`  [EXTRACTED]
  lib/data/repositories/day_repository_impl.dart → lib/domain/repositories/day_repository.dart
- `ExamRepositoryImpl` --implements--> `ExamRepository`  [EXTRACTED]
  lib/data/repositories/exam_repository_impl.dart → lib/domain/repositories/exam_repository.dart
- `SemesterRepositoryImpl` --implements--> `SemesterRepository`  [EXTRACTED]
  lib/data/repositories/semester_repository_impl.dart → lib/domain/repositories/semester_repository.dart
- `SubjectRepositoryImpl` --implements--> `SubjectRepository`  [EXTRACTED]
  lib/data/repositories/subject_repository_impl.dart → lib/domain/repositories/subject_repository.dart

## Import Cycles
- None detected.

## Communities (94 total, 18 thin omitted)

### Community 0 - "Module 0"
Cohesion: 0.04
Nodes (46): Categorize the task, ../../domain/entities/staff_subject_mapping.dart, AIService, _apiKey, category, chat, _chatHistory, _context (+38 more)

### Community 1 - "Module 1"
Cohesion: 0.05
Nodes (42): CalendarFormat, ../../domain/entities/daily_practice_log.dart, dailyPracticeLogsProvider, DailyPracticeNotifier, _loadLogs, logs, _saveLogs, _storageKey (+34 more)

### Community 2 - "Module 2"
Cohesion: 0.05
Nodes (35): ../entities/academic_day.dart, ../entities/semester.dart, close, _createDB, _database, _initDB, insert, instance (+27 more)

### Community 3 - "Module 3"
Cohesion: 0.06
Nodes (35): AndroidFlutterLocalNotificationsPlugin, ../../domain/entities/task.dart, ../../domain/providers/all_subjects_provider.dart, FlutterLocalNotificationsPlugin, int?, cancelAll, cancelTaskReminders, init (+27 more)

### Community 4 - "Module 4"
Cohesion: 0.06
Nodes (33): gpaControllerProvider, DropdownMenuItem, 0, _calculateGrade, _calculateGradePoint, gpaControllerProvider, details, exams (+25 more)

### Community 5 - "Module 5"
Cohesion: 0.07
Nodes (31): AutoDisposeAsyncNotifierProviderElement, AutoDisposeAsyncNotifierProviderImpl, AutoDisposeAsyncNotifierProviderRef, _, _allTransitiveDependencies, AttendanceControllerProvider, _AttendanceControllerProviderElement, AttendanceControllerRef (+23 more)

### Community 6 - "Module 6"
Cohesion: 0.07
Nodes (30): code, color, credits, hashCode, id, name, operator, _privateConstructorUsedError (+22 more)

### Community 7 - "Module 7"
Cohesion: 0.07
Nodes (28): activeSemesterProvider, appRouterProvider, ../../../data/repositories/semester_repository_impl.dart, ../../../domain/entities/semester.dart, FormState, repo, sem, activeSemesterAsync (+20 more)

### Community 8 - "Module 8"
Cohesion: 0.06
Nodes (30): _allTransitiveDependencies, call, combine, createElement, _dependencies, finish, getProviderOverride, month (+22 more)

### Community 9 - "Module 9"
Cohesion: 0.07
Nodes (28): taskListProvider, ../../core/services/ai_service.dart, ../../core/services/notification_service.dart, ../../data/repositories/task_repository.dart, ../../domain/entities/user_profile.dart, sharedTextProvider, addTask, build (+20 more)

### Community 10 - "Module 10"
Cohesion: 0.07
Nodes (27): _allTransitiveDependencies, call, combine, createElement, dateEpoch, _dependencies, finish, getProviderOverride (+19 more)

### Community 11 - "Module 11"
Cohesion: 0.07
Nodes (27): Duration, AIStudyAssistant, analyzeWorkload, _apiKey, attendance, blocks, date, deadlines (+19 more)

### Community 12 - "Module 12"
Cohesion: 0.08
Nodes (23): _allTransitiveDependencies, call, combine, createElement, _dependencies, finish, getProviderOverride, monthKey (+15 more)

### Community 13 - "Module 13"
Cohesion: 0.13
Nodes (23): @Deprecated, AutoDisposeFutureProvider, AutoDisposeFutureProviderElement, AutoDisposeFutureProviderRef, ActiveSemesterRef, AllSubjectsRef, AttendanceStatsRef, SeedDatabaseProvider (+15 more)

### Community 14 - "Module 14"
Cohesion: 0.11
Nodes (19): AISuggestion, actionTaken, createdAtEpoch, description, dismissed, hashCode, id, operator (+11 more)

### Community 15 - "Module 15"
Cohesion: 0.11
Nodes (19): collegeName, department, hashCode, id, name, operator, preferredStudyHours, _privateConstructorUsedError (+11 more)

### Community 16 - "Module 16"
Cohesion: 0.10
Nodes (19): _allTransitiveDependencies, call, combine, createElement, _dependencies, finish, getProviderOverride, name (+11 more)

### Community 17 - "Module 17"
Cohesion: 0.11
Nodes (18): class_timeline_widget.dart, ConsumerWidget, DateTime, CampusTrackApp, _ExamCard, ExamsScreen, build, GPAScreen (+10 more)

### Community 18 - "Module 18"
Cohesion: 0.11
Nodes (18): ../../data/repositories/timetable_repository_impl.dart, ../../domain/providers/attendance_stats_provider.dart, _assignSlot, build, _buildDayEditor, createState, initState, _isLoading (+10 more)

### Community 19 - "Module 19"
Cohesion: 0.12
Nodes (18): Color, _ActionButton, _AttendanceActions, _AttendanceStatusBadge, build, color, currentSubject, dateEpoch (+10 more)

### Community 20 - "Module 20"
Cohesion: 0.12
Nodes (17): date, hashCode, id, obtainedMarks, operator, _privateConstructorUsedError, subjectId, title (+9 more)

### Community 21 - "Module 21"
Cohesion: 0.12
Nodes (17): dueDate, hashCode, id, isCompleted, operator, _privateConstructorUsedError, subjectId, title (+9 more)

### Community 22 - "Module 22"
Cohesion: 0.11
Nodes (17): attendanceStatsProvider, ../../data/repositories/attendance_repository_impl.dart, absent, attendanceRepo, attendanceStats, attendanceStatsProvider, od, present (+9 more)

### Community 23 - "Module 23"
Cohesion: 0.12
Nodes (17): class, ../../core/services/ai_study_assistant.dart, AIStudyRecommendationCard, _AIStudyRecommendationCardState, attendancePercentages, build, createState, _getPriorityColor (+9 more)

### Community 24 - "Module 24"
Cohesion: 0.12
Nodes (17): ../../data/repositories/day_repository_impl.dart, ../../domain/providers/seed_provider.dart, build, createState, HomeScreen, _HomeScreenState, _viewingTomorrow, ../../presentation/providers/day_order_provider.dart (+9 more)

### Community 25 - "Module 25"
Cohesion: 0.12
Nodes (16): AcademicResult, @freezed, gpa, hashCode, id, operator, _privateConstructorUsedError, semesterName (+8 more)

### Community 26 - "Module 26"
Cohesion: 0.12
Nodes (17): @riverpod, AcademicResultRepository, academicResultRepositoryProvider, examRepositoryProvider, examRepository, semesterRepositoryProvider, semesterRepository, timetableRepositoryProvider (+9 more)

### Community 27 - "Module 27"
Cohesion: 0.12
Nodes (16): Attendance, AttendanceStatus get, dateEpoch, hashCode, operator, _privateConstructorUsedError, status, subjectId (+8 more)

### Community 28 - "Module 28"
Cohesion: 0.13
Nodes (14): attendanceRepositoryProvider, currentAcademicDayProvider, ../../data/database/database_helper.dart, ../../domain/entities/academic_day.dart, ../../domain/logic/day_order_calculator.dart, ../../domain/repositories/attendance_repository.dart, _db, getAttendanceForDay (+6 more)

### Community 29 - "Module 29"
Cohesion: 0.12
Nodes (16): dateEpoch, description, hashCode, id, location, name, operator, _privateConstructorUsedError (+8 more)

### Community 30 - "Module 30"
Cohesion: 0.12
Nodes (16): endDate, hashCode, id, isActive, name, operator, _privateConstructorUsedError, startDate (+8 more)

### Community 31 - "Module 31"
Cohesion: 0.12
Nodes (16): CalendarDayState, _affectsFuture, build, createState, currentState, date, DayEditorDialog, _DayEditorDialogState (+8 more)

### Community 32 - "Module 32"
Cohesion: 0.13
Nodes (15): dateEpoch, description, hashCode, id, operator, _privateConstructorUsedError, title, toJson (+7 more)

### Community 33 - "Module 33"
Cohesion: 0.13
Nodes (15): communicationStyle, hashCode, id, operator, _privateConstructorUsedError, staffName, subjectId, toJson (+7 more)

### Community 34 - "Module 34"
Cohesion: 0.13
Nodes (14): affectsFuture, dateEpoch, dayOrder, hashCode, isHoliday, isManualOverride, note, operator (+6 more)

### Community 35 - "Module 35"
Cohesion: 0.13
Nodes (13): AppTheme, darkTheme, lightTheme, background, error, ModernTheme, onPrimary, primary (+5 more)

### Community 36 - "Module 36"
Cohesion: 0.14
Nodes (14): build, _buildDayCell, _buildLegendItem, CalendarScreen, _CalendarScreenState, createState, _focusedDay, _selectedDay (+6 more)

### Community 37 - "Module 37"
Cohesion: 0.15
Nodes (12): ../../domain/entities/participation_event.dart, AchievementsScreen, build, build, createState, _descController, _locController, _nameController (+4 more)

### Community 38 - "Module 38"
Cohesion: 0.15
Nodes (13): @JsonSerializable, _, _, _, _, _, _, _ (+5 more)

### Community 39 - "Module 39"
Cohesion: 0.15
Nodes (12): bool get, aptitudeTopic, copyWith, DailyPracticeLog, date, dsaProblem, fromJson, fromMap (+4 more)

### Community 40 - "Module 40"
Cohesion: 0.18
Nodes (11): _, currentAcademicDayProvider, CurrentAcademicDay, examControllerProvider, ExamController, participationEventListProvider, ParticipationEventList, subjectControllerProvider (+3 more)

### Community 41 - "Module 41"
Cohesion: 0.24
Nodes (11): ConsumerState, ConsumerStatefulWidget, TimetableEditorScreen, _TimetableEditorScreenState, AddEventDialog, _AddEventDialogState, AddTaskDialog, _AddTaskDialogState (+3 more)

### Community 42 - "Module 42"
Cohesion: 0.20
Nodes (10): _applyNewTimetable, build, createState, _days, DebugDataDialog, _DebugDataDialogState, _deleteDay, initState (+2 more)

### Community 43 - "Module 43"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 44 - "Module 44"
Cohesion: 0.20
Nodes (9): semesterRepositoryProvider, SemesterRepositoryRef, ../../../domain/repositories/semester_repository.dart, createSemester, _db, deleteSemester, getActiveSemester, getAllSemesters (+1 more)

### Community 45 - "Module 45"
Cohesion: 0.20
Nodes (9): bGPAControllerProvider, ../../data/repositories/academic_result_repository.dart, ../../domain/entities/academic_result.dart, addResult, BGPAController, build, calculateCGPA, bGPAControllerProvider (+1 more)

### Community 46 - "Module 46"
Cohesion: 0.20
Nodes (9): dart:convert, BackupService, _dbHelper, exportData, importData, _tables, package:file_picker/file_picker.dart, package:path_provider/path_provider.dart (+1 more)

### Community 47 - "Module 47"
Cohesion: 0.20
Nodes (9): AttendanceRepositoryImpl, AttendanceLog, AttendanceRepository, getAttendanceForDay, getSemesterStats, getSubjectStats, markAttendance, status (+1 more)

### Community 48 - "Module 48"
Cohesion: 0.22
Nodes (8): dayRepositoryProvider, DayRepositoryRef, ../../domain/repositories/day_repository.dart, _db, deleteFutureComputedDays, getDay, getDaysForSemester, saveDay

### Community 49 - "Module 49"
Cohesion: 0.22
Nodes (8): examRepositoryProvider, ../../domain/entities/exam.dart, createExam, _db, deleteExam, getExamsForSemester, getExamsForSubject, updateExam

### Community 50 - "Module 50"
Cohesion: 0.22
Nodes (8): subjectRepositoryProvider, createSubject, _db, deleteSubject, getSubject, getSubjectsForSemester, updateSubject, package:sqflite/sqflite.dart

### Community 51 - "Module 51"
Cohesion: 0.22
Nodes (8): allSubjectsProvider, allSubjects, allSubjectsProvider, getSubjectsForSemester, repo, semester, ../providers/active_semester_provider.dart, ../repositories/subject_repository.dart

### Community 52 - "Module 52"
Cohesion: 0.22
Nodes (8): examControllerProvider, ../../data/repositories/exam_repository_impl.dart, ../../domain/entities/subject.dart, ../../domain/repositories/exam_repository.dart, addExam, build, deleteExam, updateMarks

### Community 53 - "Module 53"
Cohesion: 0.22
Nodes (8): importantDayListProvider, ../../data/repositories/important_day_repository.dart, ../../domain/entities/important_day.dart, addImportantDay, build, importantDayListProvider, deleteImportantDay, ImportantDayList

### Community 54 - "Module 54"
Cohesion: 0.28
Nodes (8): ../../core/services/backup_service.dart, ../../domain/providers/today_classes_provider.dart, settingsProvider, build, createState, SettingsScreen, _SettingsScreenState, ../providers/settings_provider.dart

### Community 55 - "Module 55"
Cohesion: 0.22
Nodes (8): dart:io, package:http/http.dart, String?, apiKey, envFile, lines, main, url

### Community 56 - "Module 56"
Cohesion: 0.22
Nodes (8): ../entities/exam.dart, ExamRepositoryImpl, createExam, deleteExam, ExamRepository, getExamsForSemester, getExamsForSubject, updateExam

### Community 57 - "Module 57"
Cohesion: 0.22
Nodes (8): ../entities/subject.dart, SubjectRepositoryImpl, createSubject, deleteSubject, getSubject, getSubjectsForSemester, SubjectRepository, updateSubject

### Community 58 - "Module 58"
Cohesion: 0.25
Nodes (8): AddImportantDayDialog, _AddImportantDayDialogState, build, createState, _descController, _selectedDate, _titleController, ../providers/important_day_provider.dart

### Community 59 - "Module 59"
Cohesion: 0.43
Nodes (8): AsyncValue, SeedDatabaseFamily, AcademicDayForDateFamily, ClassesForDateFamily, AttendanceControllerFamily, MonthCalendarFamily, MonthlyAttendanceStatusFamily, Family

### Community 60 - "Module 60"
Cohesion: 0.25
Nodes (7): importantDayRepositoryProvider, ImportantDayRepositoryRef, createImportantDay, _db, deleteImportantDay, getAllImportantDays, getUpcomingImportantDays

### Community 61 - "Module 61"
Cohesion: 0.25
Nodes (7): taskRepositoryProvider, TaskRepositoryRef, createTask, _db, deleteTask, getAllTasks, toggleComplete

### Community 62 - "Module 62"
Cohesion: 0.25
Nodes (7): timetableRepositoryProvider, TimetableRepositoryRef, assignSlot, clearDay, clearSlot, _db, getTimetableForDay

### Community 63 - "Module 63"
Cohesion: 0.25
Nodes (7): subjectControllerProvider, ../../data/repositories/subject_repository_impl.dart, ../../../domain/providers/active_semester_provider.dart, addSubject, build, deleteSubject, updateSubject

### Community 64 - "Module 64"
Cohesion: 0.25
Nodes (7): core/theme/app_theme.dart, ../../core/theme/modern_theme.dart, build, main, package:flutter_dotenv/flutter_dotenv.dart, package:flutter/foundation.dart, presentation/routes/app_router.dart

### Community 65 - "Module 65"
Cohesion: 0.25
Nodes (7): ../../domain/repositories/subject_repository.dart, ../../domain/repositories/timetable_repository.dart, DataSeeder, _seedDay, seedSemesterVI, _subjectRepo, _timetableRepo

### Community 66 - "Module 66"
Cohesion: 0.29
Nodes (7): AutoDisposeProviderRef, AcademicResultRepositoryRef, AttendanceRepositoryRef, ExamRepositoryRef, ParticipationEventRepositoryRef, SubjectRepositoryRef, AppRouterRef

### Community 67 - "Module 67"
Cohesion: 0.29
Nodes (6): academicResultRepositoryProvider, DatabaseHelper, addResult, _db, deleteResult, getAllResults

### Community 68 - "Module 68"
Cohesion: 0.29
Nodes (6): participationEventRepositoryProvider, createEvent, _db, deleteEvent, getAllEvents, typedef

### Community 69 - "Module 69"
Cohesion: 0.29
Nodes (6): participationEventListProvider, ../../data/repositories/participation_event_repository.dart, addEvent, build, deleteEvent, package:riverpod_annotation/riverpod_annotation.dart

### Community 70 - "Module 70"
Cohesion: 0.29
Nodes (6): TimetableRepositoryImpl, assignSlot, clearDay, clearSlot, getTimetableForDay, TimetableRepository

### Community 71 - "Module 71"
Cohesion: 0.40
Nodes (6): AcademicDay?, AcademicDayForDateProvider, _AcademicDayForDateProviderElement, AcademicDayForDateRef, AcademicDay, _AcademicDay

### Community 72 - "Module 72"
Cohesion: 0.40
Nodes (4): package:campus_track/domain/entities/academic_day.dart, package:campus_track/domain/logic/day_order_calculator.dart, package:flutter_test/flutter_test.dart, main

## Knowledge Gaps
- **755 isolated node(s):** `Priority`, `TaskCategory`, `TaskExtractionResult`, `ExtractedTask`, `UserContext` (+750 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **18 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `DatabaseHelper` connect `Module 67` to `Module 2`, `Module 68`, `Module 44`, `Module 46`, `Module 60`, `Module 48`, `Module 49`, `Module 50`, `Module 28`, `Module 61`, `Module 62`?**
  _High betweenness centrality (0.024) - this node is a cross-community bridge._
- **Why does `AttendanceRepositoryImpl` connect `Module 47` to `Module 28`?**
  _High betweenness centrality (0.017) - this node is a cross-community bridge._
- **What connects `Priority`, `TaskCategory`, `TaskExtractionResult` to the rest of the system?**
  _755 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Module 0` be split into smaller, more focused modules?**
  _Cohesion score 0.0425531914893617 - nodes in this community are weakly interconnected._
- **Should `Module 1` be split into smaller, more focused modules?**
  _Cohesion score 0.051515151515151514 - nodes in this community are weakly interconnected._
- **Should `Module 2` be split into smaller, more focused modules?**
  _Cohesion score 0.05128205128205128 - nodes in this community are weakly interconnected._
- **Should `Module 3` be split into smaller, more focused modules?**
  _Cohesion score 0.05547652916073969 - nodes in this community are weakly interconnected._