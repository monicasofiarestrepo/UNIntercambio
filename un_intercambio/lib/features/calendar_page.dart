import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:un_intercambio/features/base_page.dart';

//TODO Añadir lo de los recordatorios
//TODO hacer que cuando se abran las nuevas paginas se deseleccione el home

class CalendarPage extends StatefulWidget {
  final String title;

  const CalendarPage({Key? key, required this.title}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 3, // Índice de la pestaña para la página de calendario
      child: Column(
        children: [
          const SizedBox(height: 150),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
        ],
      ),
    );
  }
}
