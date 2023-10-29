import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

late FirebaseAuth _auth;
final _user=Rxn<User>();
late Stream<User?> _authStateChanges;
void initAuth()async{
  await Future.delayed(const Duration(seconds: 2));
  _auth=FirebaseAuth.instance;
  _authStateChanges=_auth.authStateChanges();
  _authStateChanges.listen((User?user) {
    _user.value=user;
    print("jjjjjjjjjjjjjjjjjjj""${user?.uid}");
    String? id=FirebaseAuth.instance.currentUser?.uid;
    print(id);

  });
}

