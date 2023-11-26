import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/authentication/userspage.dart';
import 'package:cmms/authentication/adminpage.dart';


import 'package:cmms/jsonmodels/users.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final username = TextEditingController();
  final password = TextEditingController();
  bool isLoginTrue = false;
  bool isvisible = false;
  final db = DatabaseHelper();
  
  
  // we have to create global 
  login() async{
   
   var response = 
   await db.login(Users(usrName:username.text, usrPassword: password.text));
   
  if(username.text == "admin" && password.text == "12345678"){
             Navigator.push(context, MaterialPageRoute(builder: (context) => Adminpage()));
  }

   
    else if(response == true)  {
    if(!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => Userpage()));
   }
   
   
   else {
    setState(() {
      isLoginTrue = true;

    });
   }
  }
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formkey,
              //we put all out textfield to a form to be controlled ant not allow as empty
              child: Column(
                children: [
                  
                  Image.asset("assets/zb.jpg"),
                
                  //username field
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFF914d)
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty){
                          return "username is required";
                          
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person,color: Colors.white,size: 45,),
                        border: InputBorder.none,
                        hintText: "username",
                        
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  //password field
                  Container(
                    margin: EdgeInsets.all(8),
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
                        
                        return null;
                      },
                      
                      obscureText: !isvisible,
                      decoration:  InputDecoration(
                        
                        icon: Icon(Icons.lock,color: Colors.white,size: 45,),
                        border: InputBorder.none,
                        hintText: "password",
                        suffixIcon: TextButton(onPressed: (){
                          setState(() {
                            isvisible = !isvisible;
                          });
                        }, child: Icon(isvisible? Icons.visibility:Icons.visibility_off,color: Colors.white,),
                        )
                        
                      ),
                    ),
                  ),
                  SizedBox(height:25,),
                  //login button
                  Container(
                    margin: EdgeInsets.fromLTRB(140, 0, 140,0),
                    height: 45,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFF914d)
              
                    ),
              
                    
                    child: TextButton(onPressed: (){
                      if (formkey.currentState!.validate()){
                        //login method will be here
                        login();
                      }
                    },
                     child: const Text("Login",
                     style: TextStyle(
                      color: Colors.white
                    ),) )),
                    SizedBox(height: 25,),
                    
                   isLoginTrue? Text("username or password is incorret!",style: TextStyle(
                    color: Colors.red
                   ),):SizedBox(),
                  
                ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}

