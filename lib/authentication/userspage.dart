

import 'package:cmms/authentication/userspages/calendar.dart';

import 'package:cmms/authentication/userspages/events.dart';
import 'package:cmms/authentication/userspages/profile.dart';



import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  int index = 0;
  final screens = [
    
   
   UserEvent(),
    
    Calendar(),

    Profile()
    

  ];
  @override
  Widget build(BuildContext context) {
    
    final items = <Widget>[
      Icon(Icons.event),
      Icon(Icons.calendar_month),
      Icon(Icons.person),
    ];
    return Scaffold(
      
      backgroundColor:   Colors.blueAccent.withOpacity(.8),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.orange[700],
        items: items,
        height: 65,
        
        animationDuration: Duration(milliseconds: 300),
      
        onTap: (index) => setState(() {
          this.index = index;
        }),
        backgroundColor: Colors.transparent,
        
      ),
      body:screens[index],




    )
    ;
  }
}