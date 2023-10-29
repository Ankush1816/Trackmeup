
import 'package:flutter/material.dart';
import 'package:trackmeup/Authentication/SignUp.dart';

import 'login_screen.dart';

class Authpages extends StatefulWidget {
  const Authpages({Key? key}) : super(key: key);

  @override
  State<Authpages> createState() => _AuthpagesState();
}

class _AuthpagesState extends State<Authpages> {
  bool showLogin=true;

  void toggle(){
    setState(() {
      showLogin=!showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return loginpage(showRegisterpage: toggle,);
    }else{
      return SignUp(showLoginpage: toggle,);
    }
  }
}
