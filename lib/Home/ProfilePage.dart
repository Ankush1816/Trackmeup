import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackmeup/Constants/colours.dart';
import 'package:trackmeup/Services/Fire_services.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    String? email = FirebaseAuth.instance.currentUser?.email;

    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            body: StreamBuilder(
              stream: FirestoreServices.getUser(email!),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs[0];
                  return SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: _height / 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 12.0, right: 12),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png'),
                                    radius: _height / 16,
                                  ),
                                ),
                                // SizedBox(
                                //   height: _height / 25,
                                // ),
                                Text(
                                  '${data['name']}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: _height / 5,
                              left: _width / 20,
                              right: _width / 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(_width / 20),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        headerChild('Rides', 1),
                                        headerChild('Attendence', 12),
                                        headerChild('Holidays', 3),
                                      ]),
                                ),
                              )
                                  .box
                                  .size(context.screenWidth * 0.95, 90)
                                  .color(Colors.white)
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .outerShadowLg
                                  .make(),
                              Padding(
                                padding: EdgeInsets.only(top: _height / 24),
                                child: Column(
                                  children: <Widget>[
                                    infoChild(
                                        _width, Icons.email, '${data['email']}'),
                                    infoChild(_width, Icons.call, '+12-1234567890'),
                                    infoChild(
                                        _width, Icons.group_add, 'Add to group'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),

          ),
        ],
      ),
    );
  }

  Widget headerChild(String header, int value) => Expanded(
          child: Column(
        children: <Widget>[
          Text(header),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: TextStyle(
                fontSize: 14.0,
                color: secondary.withOpacity(0.9),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: EdgeInsets.only(bottom: 4.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 15,
              ),
              Icon(
                icon,
                color: secondary,
                size: 30.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      )
          .box
          .size(context.screenWidth * 0.95, 90)
          .color(Colors.white)
          .rounded
          .clip(Clip.antiAlias)
          .make();
}
