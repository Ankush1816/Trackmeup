import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Product_controller extends GetxController {
  var quantity = 0.obs;
  var Colorindex = 0.obs;
  var TotalPrice = 0.obs;
  var isLiked = false.obs;
  var pImagesLinks = [];
  var p = ['a', 'b'];

  //var pImagesLists=List.generate(3, (index) => null);
  var pImagesLists = RxList<dynamic>.generate(3, (index) => null);

  changeColor(index) {
    Colorindex.value = index;
  }

  IncreaseQuantity() {
    quantity.value++;
  }

  DecreaseQuantity() {
    if (quantity.value < 1) {
    } else {
      quantity.value--;
    }
  }

  CalculatePrice(price) {
    TotalPrice.value = price * quantity.value;
  }

  AddtoCart({title, img, seller, qty, tprice, context}) async {
    final docRef = FirebaseFirestore.instance.collection("Cart").doc();
    await FirebaseFirestore.instance
        .collection("cartCollection")
        .doc(docRef.id)
        .set({
      'title': title,
      'img': img,
      //  'seller': seller,
      'qty': qty,
      'tprice': tprice,
      'addedby': FirebaseAuth.instance.currentUser?.uid,
      'p_id': docRef.id,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  AddtoLiked({title, img, seller, qty = 1, tprice, color, context}) async {
    final docRef = FirebaseFirestore.instance.collection("Cart").doc();
    await FirebaseFirestore.instance.collection("Liked").doc(docRef.id).set({
      'title': title,
      'img': img,
      //  'seller': seller,
      // 'color': color,
      'qty': qty,
      'tprice': tprice,
      'addedby': FirebaseAuth.instance.currentUser?.uid,
      'p_id': docRef.id,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  AddSeller({StoreName, Gst, Owner, Uid, Upi}) async {
    await FirebaseFirestore.instance.collection("Seller").doc().set({
      'StoreName': StoreName,
      'Gst': Gst,
      'Owner': Owner,
      'Upi': Upi,
      'Uid': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  AddLiveProducts({addedby, p_name, p_price, p_id, required p_img}) async {
    await FirebaseFirestore.instance.collection("LiveProducts").doc().set({
      'addedby': FirebaseAuth.instance.currentUser?.uid,
      'p_img': p_img,
      'p_name': p_name,
      'p_price': p_price,
      'p_id': p_id
    });
  }
  DisplayProduct({addedby, p_name, p_price, p_id, required p_img}) async {
    await FirebaseFirestore.instance.collection("Displayproduct").doc(FirebaseAuth.instance.currentUser?.uid).set({
      'addedby': FirebaseAuth.instance.currentUser?.uid,
      'p_img': p_img,
      'p_name': p_name,
      'p_price': p_price,
      'p_id': p_id
    });
  }
  AddLocation({addedby, latitude, longitude}) async {
    await FirebaseFirestore.instance.collection("Location").doc(FirebaseAuth.instance.currentUser?.uid).set({
      'addedby': FirebaseAuth.instance.currentUser?.uid,
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  AddWishlist(docId) async {
    await FirebaseFirestore.instance.collection("Liked").doc(docId).set({
      'p_wishlist':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
    }, SetOptions(merge: true));
    //
  }

  RemoveWishlist(docId) async {
    await FirebaseFirestore.instance.collection("Liked").doc(docId).set({
      'p_wishlist':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
    }, SetOptions(merge: true));
  }

  uploadImage() async {
    pImagesLinks.clear();
    for (var item in pImagesLists) {
      if (item != null) {
        var filename = basename(item.path);

        var destination =
            'vendors/${FirebaseAuth.instance.currentUser?.uid}/$filename';

        Reference ref = FirebaseStorage.instance.ref().child(destination);
        UploadTask uploadTask = ref.putFile(item);
        var n = await (await uploadTask.whenComplete(() => null))
            .ref
            .getDownloadURL();
        pImagesLinks.add(n);
        print(pImagesLinks);
      }
    }
  }

  AddProduct(
      {StoreName,
      p_description,
      Owner,
      Uid,
      p_name,
      p_price,
      p_quantity,
      p_catagory}) async {
    final docRef = FirebaseFirestore.instance.collection("Cart").doc();
    await FirebaseFirestore.instance.collection("Products").doc(docRef.id).set({
      'StoreName': StoreName,
      'p_description': p_description,
      'Owner': Owner,
      'Seller_Uid': FirebaseAuth.instance.currentUser?.uid,
      'p_image': FieldValue.arrayUnion(pImagesLinks),
      'p_name': p_name,
      'p_price': p_price,
      'p_rating': '0',
      'p_quantity': p_quantity,
      'p_catagory': p_catagory,
      'product_id': docRef.id
    });
    print(FieldValue.arrayUnion(pImagesLinks));
  }


}
