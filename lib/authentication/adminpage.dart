

import 'package:cmms/authentication/userspages/addmembers.dart';
import 'package:cmms/authentication/userspages/calendar.dart';

import 'package:cmms/authentication/userspages/profile.dart';
import 'package:cmms/view/notes.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _UserpageState();
}

class _UserpageState extends State<Adminpage> {
  int index = 0;
  final screens = [
    
   
    Notes(),
    
    Calendar(),

    Addmembers(),
    

  ];
  @override
  Widget build(BuildContext context) {
    
    final items = <Widget>[
      Icon(Icons.event,size: 30,),
      Icon(Icons.calendar_month,size: 30,),
      Icon(Icons.person_add,size: 30,),
    ];
    return Scaffold(
      backgroundColor:   Colors.white,
      
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor:Color(0xFFFF914d),
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