import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/Block/Block.dart';

class BlocAssignment extends StatelessWidget {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('BLoC Pattern'),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskListState) {
              final tasks = state.tasks;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(tasks[index].description),
                          subtitle: Text(tasks[index].isCompleted
                              ? 'Completed'
                              : 'Pending'),
                          leading: Checkbox(
                            value: tasks[index].isCompleted,
                            onChanged: (value) {
                              context.read<TaskBloc>().add(
                                    ToggleTaskEvent(index, value ?? false),
                                  );
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<TaskBloc>().add(
                                    RemoveTaskEvent(index),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: taskController,
                            decoration: InputDecoration(
                              hintText: 'Enter task description',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String description = taskController.text;
                            if (description.isNotEmpty) {
                              context.read<TaskBloc>().add(
                                    AddTaskEvent(description),
                                  );
                              taskController.clear();
                            }
                          },
                          child: Text('Add Task'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Container(); // Placeholder for loading state or other states
          },
        ),
      ),
    );
  }
}
