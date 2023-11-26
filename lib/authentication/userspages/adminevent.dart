

import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/jsonmodels/eventmodel.dart';
import 'package:cmms/pages/create_note.dart';


import 'package:flutter/material.dart';


class Adminevent extends StatefulWidget {
  const Adminevent({super.key});

  @override
  State<Adminevent> createState() => _AdmineventState();
}

class _AdmineventState extends State<Adminevent> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  @override
  void initState(){
    handler = DatabaseHelper();
    notes = handler.getNotes();
    handler.initDB().whenComplete(() {
      notes = getAllNotes();
    });
    super.initState();
  }
  Future<List<NoteModel>> getAllNotes(){
    return handler.getNotes();
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFFF914d),
      appBar: AppBar(
        title: Text("Notes"),
      ),
      
      body: Column(
        children: [
          FutureBuilder<List<NoteModel>>(
            future: notes,
            builder: (BuildContext context, AsyncSnapshot <List<NoteModel>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else if(snapshot.hasData && snapshot.data!.isEmpty){
                return Center(child: Text("no Data"));
              }
              else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              else {
                final items = snapshot.data ?? <NoteModel>[];
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title:Text(items[index].noteTitle) ,
                    );
                }
                );
          
              }
            },
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(70),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: TextButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNote()));
              
              }, child: Text("POST")),
            ),
          )
        ],
      ),
      
      

    );
  }
}