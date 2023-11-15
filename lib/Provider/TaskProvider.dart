import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';

class ProviderAssignment extends StatelessWidget {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ItemListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple SetState'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ItemListProvider>(
              builder: (context, cartProvider, child) {
                final cartItems = cartProvider.itemList;

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartItems[index].description),
                      subtitle: Text(
                          cartItems[index].isCompleted ? 'Completed' : 'Pending'),
                      leading: Checkbox(
                        value: cartItems[index].isCompleted,
                        onChanged: (value) {
                          cartProvider.updateCompletionStatus(
                            index,
                            value ?? false,
                          );
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartProvider.removeItem(index);
                        },
                      ),
                    );
                  },
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
                      cartProvider.addItem(Task(description, false));
                      taskController.clear();
                    }
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

class ItemListProvider extends ChangeNotifier {
  List<Task> itemList = [];

  void addItem(Task task) {
    itemList.add(task);
    notifyListeners();
  }

  void removeItem(int index) {
    itemList.removeAt(index);
    notifyListeners();
  }

  void updateCompletionStatus(int index, bool isCompleted) {
    itemList[index].isCompleted = isCompleted;
    notifyListeners();
  }
}

class Task {
  String description;
  bool isCompleted;

  Task(this.description, this.isCompleted);
}
