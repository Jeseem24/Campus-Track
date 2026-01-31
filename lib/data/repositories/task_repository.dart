import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/database_helper.dart';
import '../../domain/entities/task.dart';

part 'task_repository.g.dart';

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  return TaskRepository(DatabaseHelper.instance);
}

class TaskRepository {
  final DatabaseHelper _db;

  TaskRepository(this._db);

  Future<int> createTask(Task task) async {
    return await _db.insert('tasks', task.toJson());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await _db.database;
    final results = await db.query('tasks', orderBy: 'is_completed ASC, type ASC, due_date ASC');
    return results.map((e) => Task.fromJson(e)).toList();
  }

  Future<void> toggleComplete(Task task) async {
    final newStatus = !task.isCompleted;
    final db = await _db.database;
    await db.update(
      'tasks',
      task.copyWith(isCompleted: newStatus).toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
  
  Future<void> deleteTask(int id) async {
    final db = await _db.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
