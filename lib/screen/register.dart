import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pettakecarebeta23/model/profile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      appBar: AppBar(title: Text("สร้างบัญชีผู้ใช้"),),
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
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                      EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                    ]),
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
                    child: Text("ลงทะเบียน",style: TextStyle(fontSize: 20)),
                    onPressed: ()async{
                      if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      try{
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: profile.email, 
                        password: profile.password
                        );
                      formKey.currentState!.reset();
                      }on FirebaseAuthException catch(e){
                        //print(e.message);
                        Fluttertoast.showToast(
                          msg: e.message!,
                          gravity: ToastGravity.CENTER,
                        );
                      }
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
