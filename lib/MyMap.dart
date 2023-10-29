// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:latlng/latlng.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;
// import 'package:map/map.dart';
//
// class MyMap extends StatefulWidget {
//   final String user_id;
//   MyMap(this.user_id);
//   @override
//   _MyMapState createState() => _MyMapState();
// }
//
// class _MyMapState extends State<MyMap> {
//   final loc.Location location = loc.Location();
//   // late GoogleMapController _controller;
//   bool _added = false;
//   final controller = MapController(
//     location: const LatLng(0, 0),
//     zoom: 6,
//   );
//   Widget _buildMarkerWidget(Offset pos, Color color,
//       [IconData icon = Icons.location_on]) {
//     return Positioned(
//       left: pos.dx - 24,
//       top: pos.dy - 24,
//       width: 48,
//       height: 48,
//       child: GestureDetector(
//         child: Icon(
//           icon,
//           color: color,
//           size: 48,
//         ),
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (context) => const AlertDialog(
//               content: Text('You have clicked a marker!'),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('location').snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (_added) {
//               mymap(snapshot);
//             }
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return MapLayout(controller: controller, builder: (context, transformer){
//               final homeLocation = transformer.toOffset(LatLng(
//                 snapshot.data!.docs.singleWhere(
//                         (element) => element.id == widget.user_id)['latitude'],
//                 snapshot.data!.docs.singleWhere(
//                         (element) => element.id == widget.user_id)['longitude'],
//               ));
//
//               final homeMarkerWidget =
//               _buildMarkerWidget(homeLocation, Colors.black, Icons.home);
//               controller.center = LatLng(
//                 snapshot.data!.docs.singleWhere(
//                         (element) => element.id == widget.user_id)['latitude'],
//                 snapshot.data!.docs.singleWhere(
//                         (element) => element.id == widget.user_id)['longitude'],
//               );
//               controller.zoom = 10;
//               onMapCreated: (MapController controller) async {
//                 setState(() {
//                   controller = controller;
//                   _added = true;
//                 });
//               };
//
//               return GestureDetector(
//
//               );
//
//             },);
//           },
//         ));
//   }
//
//   Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
//     await controller
//         .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: LatLng(
//           snapshot.data!.docs.singleWhere(
//                   (element) => element.id == widget.user_id)['latitude'],
//           snapshot.data!.docs.singleWhere(
//                   (element) => element.id == widget.user_id)['longitude'],
//         ),
//         zoom: 14.47)));
//   }
// }