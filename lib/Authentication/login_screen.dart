import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trackmeup/Authentication/Userredirect.dart';
import 'package:trackmeup/Constants/colours.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class loginpage extends StatefulWidget {
  final VoidCallback showRegisterpage;

  const loginpage({Key? key, required this.showRegisterpage}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        key: _formKey,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: height*0.08,),
            Container(
              child: Image.network("https://cdn-icons-png.flaticon.com/512/869/869161.png",height: height*0.19,),
            ),
            SizedBox(height: height*0.055,),
            Text('Trackmeup',
                style: GoogleFonts.robotoSlab(
                    color: secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 10, bottom: 10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/2213/2213470.png',
                        color: secondary,
                        width: width*0.08,
                      ),
                      hintText: 'Email',
                      //   helperText: 'Helper Text',
                      //  counterText: '0 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: height*0.03,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      icon: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/747/747305.png',
                        color: secondary,
                        width: width*0.1,
                      ),
                      hintText: 'Password',
                      //   helperText: 'Helper Text',
                      // counterText: '0 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xFFFCAF3B),
                        ),
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ],
              )
                  .box
                  .color(Colors.white)
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowMd
                  .padding(EdgeInsets.symmetric(vertical: height*0.05, horizontal: width*0.025))
                  .make(),
            ),

            SizedBox(
              height: height*0.02,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                ),
                onPressed: () async {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                },
                child: Text('Login')),
            TextButton(
                onPressed: () {
                  widget.showRegisterpage();
                },
                style: TextButton.styleFrom(
                  foregroundColor: fontGrey,
                ),
                child: Text('New user? Create an account')),

            // SignInButtonBuilder(
            //   backgroundColor: Colors.white,
            //   onPressed: () {
            //     AuthService().signInWithGoogle();
            //   },
            //   text: 'LogIn with Google',
            //   textColor: Colors.black38,
            //   image: Image.network(
            //     'https://i.postimg.cc/tRSMjWx7/download.png',
            //     height: 30,
            //     width: 30,
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}

Widget makeinput({label, obsecureText = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 50.0, right: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        TextField(
          obscureText: obsecureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        )
      ],
    ),
  );
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
