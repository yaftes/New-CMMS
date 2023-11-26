
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today =day;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xFFFF914d),
        leading: Icon(Icons.calendar_month),
        title: Text("Calendar",style: TextStyle(
          fontWeight: FontWeight.bold,
         
        ),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

          TableCalendar(
            focusedDay:today, 
          
            firstDay: DateTime.utc(2011,10,11), 
            lastDay: DateTime.utc(2050,10,13),
            onDaySelected: _onDaySelected,
            
            headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
            selectedDayPredicate: (day) => isSameDay(day, today)
            ),
            

        ],
      ),
    );
  }
}