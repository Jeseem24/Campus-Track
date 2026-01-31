import '../../domain/entities/subject.dart';
import '../../domain/repositories/subject_repository.dart';
import '../../domain/repositories/timetable_repository.dart';

class DataSeeder {
  final SubjectRepository _subjectRepo;
  final TimetableRepository _timetableRepo;

  DataSeeder(this._subjectRepo, this._timetableRepo);

  Future<void> seedSemesterVI(int semesterId) async {
    // 1. Check if subjects exist to avoid duplicates
    final existing = await _subjectRepo.getSubjectsForSemester(semesterId);
    if (existing.isNotEmpty) return;

    // 2. Define Subjects
    final subjectsData = [
      {'code': 'HS22601', 'name': 'Professional Ethics', 'color': 0xFFE57373, 'credits': 3}, // Red
      {'code': 'CS22601', 'name': 'Compiler Design', 'color': 0xFFBA68C8, 'credits': 3},    // Purple
      {'code': 'CE22681', 'name': 'Climate Change', 'color': 0xFF64B5F6, 'credits': 3},     // Blue (Open Elective)
      {'code': 'IT22601', 'name': 'Data Science', 'color': 0xFF4DB6AC, 'credits': 3},       // Teal
      {'code': 'IT22611', 'name': 'DevOps', 'color': 0xFFFFD54F, 'credits': 3},             // Amber (Prof Elective)
      {'code': 'CS22641', 'name': 'UI/UX Design', 'color': 0xFFFF8A65, 'credits': 3},       // Deep Orange (Prof Elective)
      {'code': 'SD22601', 'name': 'Coding Skills', 'color': 0xFFA1887F, 'credits': 2},      // Brown
      {'code': 'LIB06',   'name': 'Library', 'color': 0xFF90A4AE, 'credits': 0},             // Blue Grey
      {'code': 'MENTO6',  'name': 'Mentoring', 'color': 0xFFCFD8DC, 'credits': 0},           // Grey
    ];

    final Map<String, int> codeToId = {};

    for (var data in subjectsData) {
      final subject = Subject(
        name: data['name'] as String,
        code: data['code'] as String,
        color: data['color'] as int,
        credits: data['credits'] as int,
        semesterId: semesterId,
      );
      final id = await _subjectRepo.createSubject(subject);
      codeToId[data['code'] as String] = id;
    }

    // 3. Define Timetable (Day Order 1-6)
    // Slot 1-8
    
    // Day Order 1
    // I: IT22611, II: HS22601, III: CS22641, IV: CE22681, V: CS22601, VI: CS22601, VII: IT22611, VIII: IT22601
    await _seedDay(1, ['IT22611', 'HS22601', 'CS22641', 'CE22681', 'CS22601', 'CS22601', 'IT22611', 'IT22601'], codeToId);

    // Day Order 2
    // I: HS22601, II: CS22601, III: SD22601, IV: SD22601, V: CE22681, VI: LIB06, VII: HS22601, VIII: CS22641
    await _seedDay(2, ['HS22601', 'CS22601', 'SD22601', 'SD22601', 'CE22681', 'LIB06', 'HS22601', 'CS22641'], codeToId);

    // Day Order 3
    // I: IT22611, II: IT22611, III: IT22611, IV: IT22611, V: IT22601, VI: IT22601, VII: HS22601, VIII: CS22601
    await _seedDay(3, ['IT22611', 'IT22611', 'IT22611', 'IT22611', 'IT22601', 'IT22601', 'HS22601', 'CS22601'], codeToId);

    // Day Order 4
    // I: CS22641, II: CS22641, III: CS22641, IV: CS22641, V: SD22601, VI: SD22601, VII: IT22611, VIII: IT22611
    await _seedDay(4, ['CS22641', 'CS22641', 'CS22641', 'CS22641', 'SD22601', 'SD22601', 'IT22611', 'IT22611'], codeToId);

    // Day Order 5
    // I: IT22601, II: IT22601, III: IT22601, IV: IT22601, V: HS22601, VI: CE22681, VII: CE22681, VIII: CS22601
    await _seedDay(5, ['IT22601', 'IT22601', 'IT22601', 'IT22601', 'HS22601', 'CE22681', 'CE22681', 'CS22601'], codeToId);

    // Day Order 6
    // I: CE22681, II: CE22681, III: IT22601, IV: HS22601, V: CS22601, VI: CS22601, VII: CS22641, VIII: MENTO6
    await _seedDay(6, ['CE22681', 'CE22681', 'IT22601', 'HS22601', 'CS22601', 'CS22601', 'CS22641', 'MENTO6'], codeToId);
  }

  Future<void> _seedDay(int dayOrder, List<String> codes, Map<String, int> codeToId) async {
    for (int i = 0; i < codes.length; i++) {
      final code = codes[i];
      final subjectId = codeToId[code];
      if (subjectId != null) {
        await _timetableRepo.assignSlot(dayOrder, i + 1, subjectId); // Slot 1-8
      }
    }
  }
}
