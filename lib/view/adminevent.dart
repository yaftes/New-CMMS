
import 'package:cmms/SQlite/sqlite.dart';


import 'package:cmms/jsonmodels/eventmodel.dart';
import 'package:cmms/pages/create_note.dart';

import 'package:flutter/material.dart';



class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHelper();
  final title = TextEditingController();
  final content = TextEditingController();
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
  Future<void> _refresh() async {
    setState(() {
      notes = getAllNotes();
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.event_available_sharp),
        backgroundColor: Color(0xFFFF914d),
        elevation: 0.0,
        
       title: Text("Events",style: TextStyle(
        letterSpacing: 2.0,
        
        fontWeight: FontWeight.bold
       ),),
       centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.white,
        backgroundColor: Color(0xFFFF914d),
      
        child: Text("POST",style: TextStyle(
          color: Colors.white,
        
        ),),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>CreateNote())).then((value){
          if(value){
            _refresh();
          }
        });
        
      }),
     body:  FutureBuilder<List<NoteModel>>(
      
            future: notes,
            builder: (BuildContext context, AsyncSnapshot <List<NoteModel>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else if(snapshot.hasData && snapshot.data!.isEmpty){
                return Center(child: Text(" CREATE NEW EVENTS HERE",
                style: TextStyle(
                  color: Colors.orange[200],
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
                        
                        alignment:Alignment.topCenter,
                        children: [
                           Container(
                              height: 211,
                              width: 407,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 75, 70, 70),
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 12,0),
                            height: 200,
                            width: 412,
                            decoration: BoxDecoration(
                              
                              color: Color.fromARGB(255, 203, 132, 88),
                              borderRadius: BorderRadius.circular(30),
                             
                            ),
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(child: Text(items[index].noteTitle)),
                                
                              ],
                            )),
                           
                        ],
                      ) ,


                      trailing: Column(
                       
                        children: [
                          IconButton(onPressed: (){
                            db.deleteNote(items[index].noteId!).whenComplete(() {
                                _refresh();
                            });
                          
                          }, icon: Icon(Icons.delete,color: const Color.fromARGB(255, 229, 88, 88),size: 40,)),
                       

                          
                        ],
                      ),



                      
                      onTap: (){
                        setState(() {
                          title.text = items[index].noteTitle;
                          content.text = items[index].noteContent;
                        });
                        showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: (){
                                        db.updateNote(title.text, content.text, items[index].noteId).whenComplete((){
                                          _refresh();
                                          Navigator.pop(context);
                                        });
                                      }, 
                                      child: Text("Update",style: TextStyle(
                                        color: Color(0xFFFF914d),
                                        fontWeight: FontWeight.bold
                                      ),),),
                                      TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);

                                      }, 
                                      child: Text("Cancel",style: TextStyle(
                                        color: Color(0xFFFF914d),
                                        fontWeight: FontWeight.bold
                                      ),),)
                                  ],
                                )
                              ],
                              title: Text("Update Event",style: TextStyle(
                                
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF914d)
                              ),),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                TextFormField(
                                  maxLines: null,
                                                controller: title,
                                                validator: (value){
                                                  if (value!.isEmpty){
                                                    return "title is required";
                                                   
                                                  }
                                                   return null;
                                                },
                                                decoration: InputDecoration(
                                                  label: Text("Event")
                                                ),
                                              ),
              TextFormField(
                maxLines: null,
                controller: content,
                validator: (value){
                  if (value!.isEmpty){
                    return "content is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Content")
                ),
              ),
                                ],
                              ),
                            );

                        });
                      },
                    );
                }
                );
          
              }
            },
          ),
    );
  }
}