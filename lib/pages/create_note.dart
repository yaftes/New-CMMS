
import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/authentication/adminpage.dart';
import 'package:cmms/jsonmodels/note_model.dart';
import 'package:cmms/view/notes.dart';
import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event",style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0
        ),),
        backgroundColor: Color(0xFFFF914d),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
  Navigator.push(context, MaterialPageRoute(builder:(context)=>const Adminpage()));
          }, 
          icon: Icon(Icons.arrow_back_rounded,size: 35,)),
        actions: [
          IconButton(onPressed: (){
            if(formkey.currentState!.validate()){
              db.CreateNote(NoteModel(
              noteTitle: title.text,
              noteContent: content.text, 
              createdAt: DateTime.now().toIso8601String(),
               
               )).whenComplete(() {
                  Navigator.of(context).pop(true);
               });

            }
             
          }, icon: Icon(Icons.check,size: 35,))
        ],
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
            children: [
              TextFormField(
                controller: title,
                validator: (value){
                  if (value!.isEmpty){
                    return "Event is required";
                   
                  }
                   return null;
                },
                decoration: InputDecoration(
                  label: Text("Event")
                ),
              ),
              TextFormField(
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
        ),
      ),
    );
  }
}