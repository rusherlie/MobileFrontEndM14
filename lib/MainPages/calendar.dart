import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todosapp/Provider/todosprovider.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TextEditingController judulController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController tglMulaiController = TextEditingController();
  TextEditingController tglSelesaiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final DateTime firstDay =
        DateTime.now().subtract(const Duration(days: 365));
    final DateTime lastDay = DateTime.now().add(const Duration(days: 365));
    final todosProvider = Provider.of<TodoProvider>(context);
    return Column(
      children: [
        TableCalendar(
          firstDay: firstDay,
          lastDay: lastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        ListTile(
            title: const Text('Event'),
            trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: judulController,
                                  style: const TextStyle(),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'Nama Event',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: additionalController,
                                  style: const TextStyle(),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'Keterangan tambahan',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: tglMulaiController,
                                  style: const TextStyle(),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'Tanggal mulai',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                  ),
                                  onTap: () async {
                                    var selectedDate = DateTime.now();
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      initialDatePickerMode: DatePickerMode.day,
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2101),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                        tglMulaiController.text =
                                            DateFormat('dd MMM yyyy')
                                                .format(selectedDate);
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: TextField(
                                  controller: tglSelesaiController,
                                  style: const TextStyle(),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'Tanggal selesai',
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide()),
                                  ),
                                  onTap: () async {
                                    var selectedDate = DateTime.now();
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      initialDatePickerMode: DatePickerMode.day,
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2101),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                        tglSelesaiController.text =
                                            DateFormat('dd MMM yyyy')
                                                .format(selectedDate);
                                      });
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("CANCEL",
                                  style: TextStyle(color: Colors.grey))),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  todosProvider.addEvent(
                                    judulController.text,
                                    additionalController.text,
                                    tglMulaiController.text,
                                    tglSelesaiController.text,
                                  );
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text("SET")),
                        ],
                      );
                    },
                  );
                })),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: todosProvider.eventList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todosProvider.eventList[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todosProvider.eventList[index].subtitle),
                    Text(todosProvider.eventList[index].startDate ==
                            todosProvider.eventList[index].endDate
                        ? todosProvider.eventList[index].startDate
                        : "${todosProvider.eventList[index].startDate} - ${todosProvider.eventList[index].endDate}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      todosProvider.eventList
                          .remove(todosProvider.eventList[index]);
                    });
                  },
                ),
                isThreeLine: true,
              );
            },
          ),
        )
      ],
    );
  }
}
