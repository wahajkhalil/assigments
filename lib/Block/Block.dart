import 'package:bloc/bloc.dart';
import 'package:flutterapp/Provider/TaskProvider.dart';

// Events
abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String description;

  AddTaskEvent(this.description);
}

class RemoveTaskEvent extends TaskEvent {
  final int index;

  RemoveTaskEvent(this.index);
}

class ToggleTaskEvent extends TaskEvent {
  final int index;
  final bool isCompleted;

  ToggleTaskEvent(this.index, this.isCompleted);
}

// States
abstract class TaskState {}

class TaskListState extends TaskState {
  final List<Task> tasks;

  TaskListState(this.tasks);
}

// BLoC
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task> _tasks = [];

  // Pass an initial state to the constructor
  TaskBloc() : super(TaskListState([])) {
    // Register event handlers using the 'on' method
    on<AddTaskEvent>((event, emit) {
      _tasks.add(Task(event.description, false));
      emit(TaskListState(List.from(_tasks)));
    });

    on<RemoveTaskEvent>((event, emit) {
      _tasks.removeAt(event.index);
      emit(TaskListState(List.from(_tasks)));
    });

    on<ToggleTaskEvent>((event, emit) {
      _tasks[event.index].isCompleted = event.isCompleted;
      emit(TaskListState(List.from(_tasks)));
    });
  }
}
