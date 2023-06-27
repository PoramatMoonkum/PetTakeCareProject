import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pettakecarebeta23/model/profile.dart';
import 'package:pettakecarebeta23/screen/welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
      appBar: AppBar(title: Text("เข้าสู่ระบบ"),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("อีเมล",style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                    onSaved: (email){
                      profile.email = email!;
                    },
                  ),
                  SizedBox(height: 15,),
                  Text("รหัสผ่าน",style: TextStyle(fontSize: 20)),
                  TextFormField(
                    obscureText: true,
                    validator: RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                    onSaved: (password){
                      profile.password = password!;
                    },
                  ),
                  SizedBox(
                  child :ElevatedButton(
                    child: Text("ลงชื่อเข้าใช้",style: TextStyle(fontSize: 20)),
                    onPressed: ()async{
                      formKey.currentState!.save();
                      try{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: profile.email, 
                          password: profile.password).then((value){
                          formKey.currentState!.reset();
                          Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context){
                          return WelcomeScreen();
                        }));
                      });
                      }on FirebaseAuthException catch(e){
                        print(e.message);
                      }
                    },
                  )
                  )
                ],
                ),
            ), 
              ),
        ),
      ),
    );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    
  }
}