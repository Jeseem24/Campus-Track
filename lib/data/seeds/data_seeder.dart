import '../../domain/entities/subject.dart';
import '../../domain/repositories/subject_repository.dart';
import '../../domain/repositories/timetable_repository.dart';

class DataSeeder {
  final SubjectRepository _subjectRepo;
  final TimetableRepository _timetableRepo;

  DataSeeder(this._subjectRepo, this._timetableRepo);

  Future<void> seedSemesterVII(int semesterId) async {
    // 1. Check if subjects exist to avoid duplicates
    final existing = await _subjectRepo.getSubjectsForSemester(semesterId);
    if (existing.isNotEmpty) return;

    // 2. Define Subjects
    final subjectsData = [
      {'code': 'MS22701', 'name': 'Principles of Management', 'color': 0xFFBA68C8, 'credits': 3}, 
      {'code': 'IT22701', 'name': 'Cryptography and Network Security', 'color': 0xFF4DB6AC, 'credits': 3},
      {'code': 'CE22781', 'name': 'Environment and Agriculture (OE2)', 'color': 0xFF81C784, 'credits': 3},
      {'code': 'CE22784', 'name': 'Air Pollution and Control Engineering (OE3)', 'color': 0xFF4FC3F7, 'credits': 3},
      {'code': 'IT22711', 'name': 'Advanced Web Application Development (PE5)', 'color': 0xFFFFD54F, 'credits': 3},
      {'code': 'IT22712', 'name': 'Digital Marketing (PE6)', 'color': 0xFFFF8A65, 'credits': 3},
      {'code': 'IT22722', 'name': 'Generative AI (PE6)', 'color': 0xFF64B5F6, 'credits': 3},
      {'code': 'IT22702', 'name': 'Security Lab', 'color': 0xFFE57373, 'credits': 2},
      {'code': 'IT22703', 'name': 'Mini Project', 'color': 0xFF7986CB, 'credits': 2},
      {'code': 'SD22701', 'name': 'Coding Skills and Quantitative Aptitude - Phase II', 'color': 0xFFA1887F, 'credits': 2},
      {'code': 'IT22731', 'name': 'Business Intelligence (Honours)', 'color': 0xFFF06292, 'credits': 3},
      {'code': 'IT22732', 'name': 'Social Media Analytics (Honours)', 'color': 0xFFD4E157, 'credits': 3},
      {'code': 'LIB07',   'name': 'Library', 'color': 0xFF90A4AE, 'credits': 0},
      {'code': 'MENT07',  'name': 'Mentoring', 'color': 0xFFCFD8DC, 'credits': 0},
      {'code': 'ST07',    'name': 'Placement / Communication Skill', 'color': 0xFF4DD0E1, 'credits': 0},
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

    // 3. Define Timetable (Day Order 1-5)
    
    // Day Order 1
    await _seedDay(1, ['CE22784', 'IT22701', 'IT22712', 'IT22712', 'SD22701', 'SD22701', 'SD22701', 'SD22701'], codeToId);

    // Day Order 2
    await _seedDay(2, ['IT22701', 'MS22701', 'IT22711', 'IT22711', 'CE22781', 'LIB07', 'ST07', 'ST07'], codeToId);

    // Day Order 3
    await _seedDay(3, ['CE22781', 'IT22701', 'CE22784', 'CE22781', 'IT22701', 'MS22701', 'MENT07', 'MENT07'], codeToId);

    // Day Order 4
    await _seedDay(4, ['IT22711', 'CE22784', 'IT22703', 'IT22703', 'IT22702', 'IT22702', 'IT22702', 'IT22702'], codeToId);

    // Day Order 5
    await _seedDay(5, ['MS22701', 'IT22711', 'IT22712', 'IT22712', 'IT22703', 'IT22703', 'IT22703', 'IT22703'], codeToId);
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
