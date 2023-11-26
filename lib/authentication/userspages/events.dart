
import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/jsonmodels/eventmodel.dart';

import 'package:flutter/material.dart';


class UserEvent extends StatefulWidget {
  const UserEvent({super.key});

  @override
  State<UserEvent> createState() => _UserEventState();
}

class _UserEventState extends State<UserEvent> {
  @override
late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  @override
  void initState() {
    handler = DatabaseHelper();
    notes = handler.getNotes();
    handler.initDB().whenComplete(() {
      notes = handler.getNotes();
    });
    super.initState();
  }
  Future<List<NoteModel>> getAllNotes(){
    return handler.getNotes();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.event_available),
       title: Text("Events",style: TextStyle(
        fontWeight: FontWeight.bold
       ),),
       centerTitle: true,
       backgroundColor: Colors.orange[700],
      ),
      
     body:  FutureBuilder<List<NoteModel>>(
            future: notes,
            builder: (BuildContext context, AsyncSnapshot <List<NoteModel>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else if(snapshot.hasData && snapshot.data!.isEmpty){
                return Center(child: Text("No event is available",style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20
                ),));
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
                      title:Stack(
                        children: [
                          Container(
                            height: 210,
                            width: 405,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 12, 4),
                            width: 405,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF914d),
                          
                              borderRadius: BorderRadius.circular(30)
                            
                          
                              
                            ),
                            child: Center(child: Text(items[index].noteTitle,style: TextStyle(
                              color: Colors.white
                            ),))),
                            
                        ],
                      ) ,
                    );
                }
                );
          
              }
            },
          ),
    );
}
}