import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/task.dart';
import '../../data/repositories/task_repository.dart';

part 'task_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    final repo = ref.watch(taskRepositoryProvider);
    return await repo.getAllTasks();
  }

  Future<void> addTask(Task task) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.createTask(task);
    ref.invalidateSelf();
  }

  Future<void> toggleTask(Task task) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.toggleComplete(task);
    ref.invalidateSelf();
  }
  
  Future<void> deleteTask(int id) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.deleteTask(id);
    ref.invalidateSelf();
  }
}
