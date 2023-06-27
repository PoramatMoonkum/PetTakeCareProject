import 'package:flutter/material.dart';
import 'package:pettakecarebeta23/screen/login.dart';
import 'package:pettakecarebeta23/screen/register.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pet Take Care"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
            Image.asset("assets/images/logopet.png"),
            SizedBox(
              child: 
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("สร้างบัญชีผู้ใช้",style:TextStyle(fontSize: 20)),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return RegisterScreen();
                  })
              );
              },
              ),
             ),
             SizedBox(
              child: 
            ElevatedButton.icon(
              icon: Icon(Icons.login),
              label: Text("เข้าสู่ระบบ",style:TextStyle(fontSize: 20)),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return LoginScreen();
                  })
              );
              },
              ),
             )
            ],
          ),
        ),
      ),
    );
  }
}