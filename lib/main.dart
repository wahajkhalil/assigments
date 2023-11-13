import 'package:flutter/material.dart';

void main() {
  runApp(TaskListScreen());
}
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].discription),
                  subtitle: Text(tasks[index].isCompleted ? 'Completed' : 'Pending'),
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) {
                      setState(() {
                        tasks[index].isCompleted = value!;
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
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
                    setState(() {
                      String description = taskController.text;
                      if (description.isNotEmpty) {
                        tasks.add(Task(description, false));
                        taskController.clear();
                      }
                    });
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class TaskListApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       home:TaskListScreen(),
//     );
//
//   }
//
// }
//
// class TaskListScreen extends StatefulWidget {
//   @override
//   _TaskListScreenState createState() => _TaskListScreenState();
// }
class Task{
  String discription;
  bool isCompleted;
  Task(this.discription,this.isCompleted);

}
//
// class _TaskListScreenState  extends State<TaskListScreen>{
//   List <Task> tasks=[];
//   TextEditingController taskController=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text("Task Lists")),
//       body: Column(
//         children: [
//           Expanded(child: ListView.builder(
//              itemCount: tasks.length,
//               itemBuilder:(context, index) {
//                 return ListTile(
//                   title: Text(tasks[index].discription),
//                   leading: Checkbox(
//                     value: tasks[index].isCompleted,
//                     onChanged: (value) {
//                       setState(() {
//                         tasks[index].isCompleted=value!;
//
//                       });
//                     },
//
//                   ),
//                     trailing:IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         setState(() {
//                           tasks.removeAt(index);
//                         });
//                       },
//
//                     )
//                 );
//               },))
//         ],
//       ),
//
//     );
//   }
//
// }
