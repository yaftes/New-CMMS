import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/authentication/login.dart';
import 'package:cmms/jsonmodels/users.dart';
import 'package:flutter/material.dart';

class Addmembers extends StatefulWidget {
  const Addmembers({super.key});

  @override
  State<Addmembers> createState() => _AddmembersState();
}

class _AddmembersState extends State<Addmembers> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmpassword= TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool isvisible = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF914d),
        title: Text("Add Members",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        leading:  IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>const LoginScreen()));
            }, icon: Icon(Icons.logout_rounded,size: 30,)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 240,
                      width: 240,
                      child: Center(child: Text("Add New Member",style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8
                        
                      ),)),
                    ),
                    SizedBox(width: 20,),
                    Icon(Icons.person_add_alt,size: 50,color: Color(0xFFFF914d),
                    )
                  ],
                ),
                
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFF914d),
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty){
                          return "username is required";
                          
                        }
                         else if(value.length<5){
                          return "username must be atleast 5 character long ";

                        }
                        else if (value.length > 10){
                          return "username should be less than 10 characters";
                        }
                        
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person,color: Colors.white,size: 40,),
                        border: InputBorder.none,
                        hintText: "username",
                        
                        
                      ),
                    ),
                  ),
                       
                       
                       
                        SizedBox(height: 25,),
                        //login button
                        
                           
                           Container(
                       margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFFF914d)
                      ),
                      child: TextFormField(
                        controller: password,
                        validator: (value){
                          if(value!.isEmpty){
                            return "password is required";
                            
                          }
                          else if(value.length<8){
                          return "password must be atleast 8 character long ";

                        }
                         else if (value.length > 16){
                          return "password should be less than 16 characters";
                        }
                        
                          
                          return null;
                        },
                        
                        obscureText: !isvisible,
                        decoration:  InputDecoration(
                          icon: Icon(Icons.lock,color: Colors.white,size: 35,),
                          border: InputBorder.none,
                          hintText: "password",
                          suffixIcon: TextButton(onPressed: (){
                            setState(() {
                              isvisible = !isvisible;
                            });
                          }, child: Icon(isvisible? Icons.visibility:Icons.visibility_off,color: Colors.white,))
                          
                        ),
                      ),
                    ),
                          SizedBox(height: 25,),
                        Container(
                       margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFFF914d)
                      ),
                      child: TextFormField(
                        controller: confirmpassword,
                        
                        validator: (value){
                          if(value!.isEmpty){
                            return "password is required";
                            
                          }
                          else if ( password.text != confirmpassword.text){
                              return "password don't match";
                          }
                          return null;
                        },
                        
                        obscureText: !isvisible,
                        decoration:  InputDecoration(
                          icon: Icon(Icons.lock,color: Colors.white,size: 35,),
                          border: InputBorder.none,
                          hintText: "confirm",
                          suffixIcon: TextButton(onPressed: (){
                            setState(() {
                              isvisible = !isvisible;
                            });
                          }, child: Icon(isvisible? Icons.visibility:Icons.visibility_off,color: Colors.white,))
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 45,)
,            Container(
                    margin: EdgeInsets.fromLTRB(130, 0,130, 0),
                    height: 55,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFF914d)
              
                    ),
              
                    
                    child: TextButton(onPressed: (){
                      
                     
                      if (formkey.currentState!.validate()){
                        //login method will be here
                        final db = DatabaseHelper();
                       
                        db.signup(Users(usrName:username.text , usrPassword: password.text));
                      }
                    },
                     child: Center(
                       child: const Text("Add Member",
                       style: TextStyle(
                        color: Colors.white
                                           ),),
                     ) )),
                    
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
}