

import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/authentication/login.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final newpassword = TextEditingController();
  final newusername = TextEditingController();
  final db = DatabaseHelper();
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFFFF914d),
        leading:
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>const LoginScreen()));
            }, icon: Icon(Icons.logout)),
          
        title: Text("Profile",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          SizedBox(height: 70,),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                color: Color(0xFFFF914d),
                borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(Icons.person,size: 100,color: Colors.white,)),
            SizedBox(height: 60,),
                    //username field
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFFF914d)
                      ),
                      child: TextFormField(
                        controller: newusername,
                       
                        validator: (value){
                          if(value!.isEmpty){
                            return "username is required";
                            
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person,color: Colors.white,),
                          border: InputBorder.none,
                          hintText: "username",
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    //password field
                    Container(
                      margin: EdgeInsets.all(25),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFFF914d)
                      ),
                      child: TextFormField(
                        controller: newpassword,
                        validator: (value){
                          if(value!.isEmpty){
                            return "username is required";
                            
                          }
                          return null;
                        },
                        
                        
                        decoration:  InputDecoration(
                          
                          icon: Icon(Icons.lock,color: Colors.white,),
                          border: InputBorder.none,
                          hintText: "password",
                          suffixIcon: TextButton(onPressed: (){
                            setState(() {
                              
                            });
                          }, child: Icon(Icons.visibility,color: Colors.white,),
                          )
                          
                        ),
                      ),
                    ),
                    SizedBox(height:15,),
                    //login button
                    Container(
                      margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
                      height: 55,
                      width: MediaQuery.of(context).size.width*.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFFF914d)
                
                      ),
                
                      
                      child: TextButton(onPressed: (){
                       
                      },
                       child: const Text("UPDATE",
                       style: TextStyle(
                        color: Colors.white
                      ),) )),
            
          ],
        ),
      )
    );
    
  }

    }

    
   