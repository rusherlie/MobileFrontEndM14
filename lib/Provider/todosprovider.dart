import 'package:flutter/material.dart';

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

class Event {
  final String title;
  final String subtitle;
  final String startDate;
  final String endDate;

  Event(this.title, this.subtitle, this.startDate, this.endDate);
}

class Stuff {
  String label;
  Color color;

  Stuff(this.label, this.color);
}

class TodoProvider with ChangeNotifier {
  final List<Todo> _originalTodos = [];
  List<Todo> _filteredTodos = [];
  final List<Event> _eventList = [];
  String? value;

  final List<Stuff> _stuff = [
    Stuff('Work', Colors.red),
    Stuff('Routine', Colors.amber),
    Stuff('Others', Colors.blue),
  ];

  List<Stuff> get stuff => _stuff;
  List<Event> get eventList => _eventList;
  List<Todo> get originalTodos => _originalTodos;
  List<Todo> get filteredTodos => _filteredTodos;
  List<Todo> get finishedTodos =>
      _filteredTodos.where((check) => check.isChecked).toList();
  List<Todo> get unfinishedTodos =>
      _filteredTodos.where((check) => !check.isChecked).toList();

  void addTodo(String title, String description, String startDate,
      String endDate, String category) {
    _originalTodos.add(Todo(
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      category: category,
      isChecked: false,
    ));
    _filteredTodos = _originalTodos;
    notifyListeners();
  }

  void addEvent(
      String title, String subtitle, String startDate, String endDate) {
    _eventList.add(Event(title, subtitle, startDate, endDate));
    notifyListeners();
  }

  void selectChip(String? choice) {
    List<Todo> filter;
    if (choice != null) {
      filter = _originalTodos
          .where((tile) => tile.category.contains(choice))
          .toList();
    } else {
      filter = _originalTodos;
    }
    _filteredTodos = filter;
    value = choice;
    notifyListeners();
  }

  int undoneNumber(String item) {
    return _originalTodos
        .where((tile) => tile.category.contains(item) && !tile.isChecked)
        .length;
  }

  int doneNumber(String item) {
    return _originalTodos
        .where((tile) => tile.category.contains(item) && tile.isChecked)
        .length;
  }

  Widget counter(int num) {
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          num.toString(),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
