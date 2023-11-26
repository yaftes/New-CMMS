import 'package:cmms/SQlite/sqlite.dart';
import 'package:cmms/authentication/login.dart';
import 'package:cmms/jsonmodels/users.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmpassword= TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool isvisible = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    "Register New Account",
                    style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),
                  ),
        
                ),
                SizedBox(height: 25,),
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
                        color: Color(0xFFFF914d),
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
                          hintText: "Confirm",
                          suffixIcon: TextButton(onPressed: (){
                            setState(() {
                              isvisible = !isvisible;
                            });
                          }, child: Icon(isvisible? Icons.visibility:Icons.visibility_off,color: Colors.white,))
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 55,)
,            Container(
                    margin: EdgeInsets.fromLTRB(150, 0,150, 0),
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
                       
                        db.signup(Users(usrName:username.text , usrPassword: password.text)).whenComplete(() => 
                        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())));
                      }
                    },
                     child: const Text("Signup",
                     style: TextStyle(
                      color: Colors.white
                    ),) )),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15

                        ),),
                       TextButton(onPressed: () {
                        //navigate to signup
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>const LoginScreen()));

                       }, child: Text("Login",style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFF914d)
                       ),) )
              
                      ],
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}