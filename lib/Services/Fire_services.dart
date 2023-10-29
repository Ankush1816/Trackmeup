
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirestoreServices{
//get users data
  static getUser(String email){
    return  FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: email).snapshots();

  }
  static getLocation(String addedby){
    return  FirebaseFirestore.instance.collection('UserLocation').where('addedby', isEqualTo: addedby).snapshots();

  }
  static getSellerProducts(String id){
    return  FirebaseFirestore.instance.collection('Products').where('Seller_Uid', isEqualTo: id).snapshots();

  }

  static getProducts(catagory){
    return  FirebaseFirestore.instance.collection('Products').where('p_catagory', isNotEqualTo: catagory).snapshots();
  }
  static getSellers(){
    return  FirebaseFirestore.instance.collection('Users').where('seller', isEqualTo: "true").snapshots();
  }
static getCart(String id){
  return  FirebaseFirestore.instance.collection('Cart').where('addedby', isEqualTo: id).snapshots();
}
  static LiveCart(String id){
    return  FirebaseFirestore.instance.collection('LiveProducts').where('addedby', isEqualTo: id).snapshots();
  }
  static DisplayProduct(String id){
    return  FirebaseFirestore.instance.collection('Displayproduct').where('addedby', isEqualTo: id).snapshots();
  }
  static getCart2(String id){
    return  FirebaseFirestore.instance.collection('Cart').where('addedby', isEqualTo: id).snapshots();
  }
  static deleteDoc(String docid){
    return  FirebaseFirestore.instance.collection("cartCollection").doc(docid).delete();
  }
  static deleteSaved(String docid){
    return  FirebaseFirestore.instance.collection('Liked').doc(docid).delete();
  }
  static getLiked(String id){
    return  FirebaseFirestore.instance.collection('Liked').where('addedby', isEqualTo: id).snapshots();

  }

}
