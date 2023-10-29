import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackmeup/Authentication/Authuser.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthUser()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://cdn-icons-png.flaticon.com/512/2055/2055340.png',height: 200),
            SizedBox(height: 60,),
            Text('Trackmeup',style: GoogleFonts.robotoSlab(color: Color(0xFFFEB9BB),fontWeight: FontWeight.bold,fontSize: 38)),
            SizedBox(height: 55,),

          ],
        ),
      ),
    );
  }
}
