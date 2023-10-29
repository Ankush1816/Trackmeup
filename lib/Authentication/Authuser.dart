
import 'package:flutter/material.dart';
import 'package:trackmeup/Authentication/Userredirect.dart';

class AuthUser extends StatefulWidget {
  const AuthUser({Key? key}) : super(key: key);

  @override
  State<AuthUser> createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuthState(),
    );
  }
  }

