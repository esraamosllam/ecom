import 'package:firebase_auth/firebase_auth.dart';
import '../Pages/signIn.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp>{

  String _email , _password ,_name ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator:(input){
                if(input.isEmpty){
                  return 'Please type your name';
                }
              } ,
              onSaved:(input)=>_name = input,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              validator:(input){
                if(input.isEmpty){
                  return 'Please type email';
                }
              } ,
              onSaved:(input)=>_email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),

             TextFormField(
              validator:(input){
                if(input.length < 6){
                  return 'Your password need to be at least 6 characters';
                }
              } ,
              onSaved:(input)=>_password = input,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign in'),
            )
          ],
        ),
      ),
    );

   
  }
   Future<void> signUp()async{
      //final FormState = _formKey.currentState;

      if (_formKey.currentState.validate()){
        _formKey.currentState.save();
        try{
          AuthResult user =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email,
         password:_password ) ;
         
         //user.sendEmailVerification();
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginPage()));

        // Navigator.of(context).pop();
        }
        catch(e){
          print(e.message);
        }
        
      }
    }


}
