import 'package:provider/provider.dart';
import 'package:todosapp/Provider/todosprovider.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  void onSaveTodo(String title, String description, String startDate,
      String endDate, String category, BuildContext context) {
    final todosProvider = Provider.of<TodoProvider>(context);
    todosProvider.addTodo(title, description, startDate, endDate, category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final todosProvider = Provider.of<TodoProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(
              todosProvider.stuff.length,
              (int index) {
                var item = todosProvider.stuff;
                return ChoiceChip(
                  label: Text(item[index].label),
                  selectedColor: item[index].color,
                  backgroundColor: Colors.white70,
                  side: BorderSide(color: item[index].color, width: 2),
                  selected: todosProvider.value == item[index].label,
                  onSelected: (bool value) {
                    setState(() {
                      todosProvider.value = value ? item[index].label : null;
                    });
                    if (value) {
                      todosProvider.selectChip(item[index].label);
                    } else {
                      todosProvider.selectChip(null);
                    }
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Unfinished'),
                      Divider(),
                    ],
                  ),
                ),
                if (todosProvider.unfinishedTodos.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: todosProvider.unfinishedTodos.length,
                    itemBuilder: (context, index) {
                      final todo = todosProvider.unfinishedTodos[index];
                      return Card(
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ExpansionTile(
                          leading: Checkbox(
                            value: todo.isChecked,
                            activeColor: todosProvider.stuff
                                .firstWhere(
                                    (element) => element.label == todo.category)
                                .color,
                            side: BorderSide(
                                color: todosProvider.stuff
                                    .firstWhere((element) =>
                                        element.label == todo.category)
                                    .color,
                                width: 2),
                            onChanged: (bool? value) {
                              setState(() {
                                todo.isChecked = value ?? false;
                              });
                            },
                          ),
                          title: Text(
                            todo.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Text(
                            '${todo.startDate} s/d ${todo.endDate}',
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          children: <Widget>[
                            ListTile(
                                title: Text(
                              todo.description,
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Finished',
                      ),
                      Divider(),
                    ],
                  ),
                ),
                if (todosProvider.finishedTodos.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: todosProvider.finishedTodos.length,
                    itemBuilder: (context, index) {
                      final todo = todosProvider.finishedTodos[index];
                      return Card(
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ExpansionTile(
                          leading: Checkbox(
                            value: todo.isChecked,
                            activeColor: todosProvider.stuff
                                .firstWhere(
                                    (element) => element.label == todo.category)
                                .color,
                            side: BorderSide(
                                color: todosProvider.stuff
                                    .firstWhere((element) =>
                                        element.label == todo.category)
                                    .color,
                                width: 2),
                            onChanged: (bool? value) {
                              setState(() {
                                todo.isChecked = value ?? false;
                              });
                            },
                          ),
                          title: Text(
                            todo.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Text(
                            '${todo.startDate} s/d ${todo.endDate}',
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          children: <Widget>[
                            ListTile(
                                title: Text(
                              todo.description,
                            )),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Stuff {
  String label;
  Color color;

  Stuff(this.label, this.color);
}

class Todo {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String category;
  bool isChecked;

  Todo({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.category,
    this.isChecked = false,
  });
}
