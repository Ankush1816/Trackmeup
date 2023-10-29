import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trackmeup/Authentication/Userredirect.dart';
import 'package:trackmeup/Constants/colours.dart';
import 'package:trackmeup/Home/HomePage.dart';
import 'package:velocity_x/velocity_x.dart';



FirebaseAuth auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  final VoidCallback showLoginpage;

  const SignUp({Key? key, required this.showLoginpage}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _seller = TextEditingController();

  late bool _success;
  late String _userEmail;
  bool isChecked = false;
  bool newValue = true;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        key: _formKey,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height*0.08,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.postimg.cc/tgLKrj0q/Screenshot-2023-03-17-22-09-39-866-com-whatsapp-1-removebg-preview.png"

                        ),
                        fit: BoxFit.cover)),
                height: height*0.1,
                width: width*0.4,
              ),
            ),
            SizedBox(
              height: height*0.02,
            ),
            Image.network('https://cdn-icons-png.flaticon.com/512/3767/3767238.png',height: height*0.08,),
            SizedBox(
              height: height*0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),

              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail,color: secondary,),
                      hintText: 'Email',
                      //   helperText: 'Helper Text',
                      //  counterText: '0 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Color(0xFFFCAF3B)),
                      ),
                    ),
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: height*0.02,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock,color: secondary,),
                      hintText: 'Password',
                      //   helperText: 'Helper Text',
                      // counterText: '0 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(
                          color: Color(0xFFFCAF3B),
                        ),
                      ),
                    ),
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person,color: secondary,),
                      hintText: 'Name',
                      //   helperText: 'Helper Text',
                      //  counterText: '0 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(color: Color(0xFFFCAF3B)),
                      ),
                    ),
                    controller: _name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone,color: secondary,),
                      hintText: 'Phone number',
                      //   helperText: 'Helper Text',
                      //  counterText: '0 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: secondary),
                      ),
                    ),
                    controller: _phone,
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     icon: Icon(Icons.home_filled),
                  //     hintText: 'Address',
                  //     //   helperText: 'Helper Text',
                  //     //  counterText: '0 characters',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(25),
                  //       borderSide: BorderSide(color: Color(0xFFFCAF3B)),
                  //     ),
                  //   ),
                  //   controller: _address,
                  // ),
                  SizedBox(
                    height: height*0.02,
                  ),
                ],
              ).box
                  .color(Colors.white)
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowMd
                  .padding(EdgeInsets.symmetric(vertical: height*0.012, horizontal: width*0.02))
                  .make(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              child: Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      }),
                  Text("Please accept our"),
                  TextButton(
                      onPressed: () {Get.to(HomePage());}, child: Text('terms and conditions.'))
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                ),
                onPressed: () async {
                  if(isChecked==true){
                    _register();
                  }else{
                    VxToast.show(context,
                        msg: "Please accept our terms and conditions");
                  }

                },
                child: Text('SignUp')),
            TextButton(
                onPressed: () {
                  widget.showLoginpage();
                },
                style: TextButton.styleFrom(
                  foregroundColor: fontGrey,
                ),
                child: Text('Already have?Login')),
            const SizedBox(
              height: 0,
            ),
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

  Future<void> _register() async {
    if (isChecked = true) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        createuser(
            _emailController.text, _name.text, _phone.text, _address.text,_seller.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          VxToast.show(context, msg: 'weak password');
        } else if (e.code == 'email-already-in-use') {
          VxToast.show(context, msg: 'email already in use');
        }
      } catch (e) {
        print(e);
      }
    } else {
      VxToast.show(context, msg: 'Something went wrong');
    }
  }
}

Future createuser(String email, String name, String phone,
    String address,String location) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid);
  final user = User(
    id: docUser.id,
    email: email,
    name: name,
    phone: phone,
    address: address,
    location: location,
  );
  final json = user.toJson();
  await docUser.set(json);
}

class User {
  String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String location;

  User({
    required this.location,
    this.id = '',
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'seller': location,
        'email': email,
        'name': name,
        'phone no': phone,
        'address':address,

      };

  static User fromJson(Map<String, dynamic> json) =>
      User(email: json['email'], name: json['name'], phone: json['phone'], address: json['address'], location: json['seller']);

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

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//
//   GoogleSignInAccount get user => _user!;
//
//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;
//
//     final googleAuth = await googleUser.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     notifyListeners();
//   }
//
// }
