import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trackmeup/Constants/colours.dart';
import 'package:trackmeup/Home/MapPage.dart';
import 'package:trackmeup/MyMap.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:trackmeup/Widgets/ButtonSmall.dart';
import 'package:velocity_x/velocity_x.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.low);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    String name1 = "";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              alignment: Alignment.center,
              // height: 60,
              color: Colors.grey.shade300,
              child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      color: secondary.withOpacity(0.8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Search',
                  ),
                  onChanged: (val) {
                    setState(() {
                      name1 = val;

                    });
                  },
              ),
            ),
          ),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Buttons_small(
                  Textcolor: Colors.black,
                  BackgroundColor: Colors.white,
                  text: "Add location",
                  icon: Icons.add_location_alt,
                  size: 105,
                  Iconsize: 40,
                  Iconcolor: Colors.green,
                  ontap: _getLocation,
                ),
                Buttons_small(
                  Textcolor: Colors.black,
                  BackgroundColor: Colors.white,
                  text: "Share location",
                  icon: Icons.share_location,
                  size: 105,
                  Iconsize: 40,
                  Iconcolor: Colors.blueAccent,
                  ontap: _listenLocation,
                ),
                Buttons_small(
                  Textcolor: Colors.black,
                  BackgroundColor: Colors.white,
                  text: "Stop sharing ",
                  icon: Icons.stop_circle_sharp,
                  size: 105,
                  Iconsize: 40,
                  Iconcolor: Colors.red,
                  ontap: _stopListening,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4, bottom: 4),
            child: Row(
              children: [
                Text(
                  "Currently live:-",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: secondary.withOpacity(0.9)),
                ),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('location').snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                        if (name1.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                title: Text(snapshot.data!.docs[index]['name']
                                    .toString()),
                                subtitle: Row(
                                  children: [
                                    Text(snapshot.data!.docs[index]['latitude']
                                        .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(snapshot.data!.docs[index]['longitude']
                                        .toString())
                                  ],
                                ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.directions,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => MyMap(
                                                    snapshot.data!.docs[index]
                                                        .id)));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.bookmark_outlined,
                                        color: Colors.yellow,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => MyMap(
                                                    snapshot.data!.docs[index]
                                                        .id)));
                                      },
                                    ),
                                  ],
                                ))
                                .box
                                .size(context.screenWidth * 0.95, 90)
                                .color(Colors.white)
                                .rounded
                                .clip(Clip.antiAlias)
                                .outerShadowMd
                                .make(),
                          );
                        }
                        if (data['name']
                            .toString()
                            .toLowerCase()
                            .startsWith(name1.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(

                                title: Text(snapshot.data!.docs[index]['name']
                                    .toString()),
                                subtitle: Row(
                                  children: [
                                    Text(snapshot.data!.docs[index]['latitude']
                                        .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(snapshot.data!.docs[index]['longitude']
                                        .toString())
                                  ],
                                ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.directions,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => MyMap(
                                                    snapshot
                                                        .data!.docs[index].id)));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.bookmark_outlined,
                                        color: Colors.yellow,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => MyMap(
                                                    snapshot
                                                        .data!.docs[index].id)));
                                      },
                                    ),
                                  ],
                                ))
                                .box
                                .size(context.screenWidth * 0.95, 90)
                                .color(Colors.white)
                                .rounded
                                .clip(Clip.antiAlias)
                                .outerShadowMd
                                .make(),
                          );
                        }
                        return Container();
                      });
                },
              )),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('location')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': FirebaseAuth.instance.currentUser?.email
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc(FirebaseAuth.instance.currentUser?.uid).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': FirebaseAuth.instance.currentUser?.email,
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

Widget A({required Icon, required onpressed, required text}) {
  return Container(
    child: Column(
      children: [
        Icon(Icon),
        8.heightBox,
        Text(text),
      ],
    ),
  ).box.make().onTap(() {
    onpressed;
  });
}
