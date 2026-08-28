import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/task.dart';
import '../../data/repositories/task_repository.dart';
import '../../core/services/notification_service.dart';

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
    final id = await repo.createTask(task);
    
    final taskWithId = task.copyWith(id: id);
    await NotificationService().scheduleTaskReminders(taskWithId);
    await _updateDailySummary();
    
    ref.invalidateSelf();
  }

  Future<void> toggleTask(Task task) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.toggleComplete(task);
    
    // Update or cancel reminders based on new status
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await NotificationService().scheduleTaskReminders(updatedTask);
    await _updateDailySummary();

    ref.invalidateSelf();
  }
  
  Future<void> deleteTask(int id) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.deleteTask(id);
    await NotificationService().cancelTaskReminders(id);
    await _updateDailySummary();

    ref.invalidateSelf();
  }

  Future<void> _updateDailySummary() async {
    final repo = ref.read(taskRepositoryProvider);
    final tasks = await repo.getAllTasks();
    final pendingCount = tasks.where((t) => !t.isCompleted).length;
    await NotificationService().updateDailySummary(pendingCount);
  }
}
