import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Databasemodel with ChangeNotifier {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  //User Details

  Future<void> getUserDetails() async {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    final DocumentSnapshot userDoc = await userCollection.doc(uid).get();
    if (userDoc.exists) {
      _userData = userDoc.data() as Map<String, dynamic>;
      notifyListeners();
    } else {
      print('User not found');
    }
  }


  //update user details
  Future<void> updateUserData(String name, String number, String email,
      String state, String pin, String gender) async {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
     userCollection.doc(uid).update({
      'name': name,
      'number': number,
      'email': email,
      'state': state,
      'pin': pin,
      'gender': gender,
      'uid' : uid
    });
    getUserDetails();
    notifyListeners();
  }

  //add address
  Future<void> addNewAddress(String name, String number, String address,
      String state, String pin, String landmark) async {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
     await userCollection.doc(uid).collection('address').add({
      'name': name,
       'number' : number,
       'State' : state,
       'pin' : pin,
       'address' : address,
       'landmark' : landmark,
    });
  }

  Future<void> updateAddress(String name, String number, String address,
      String state, String pin, String landmark,String docId) async {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    return await userCollection.doc(uid).collection('address').doc(docId).update({
      'name': name,
      'number' : number,
      'State' : state,
      'pin' : pin,
      'address' : address,
      'landmark' : landmark,
    });
  }

  Stream<QuerySnapshot> getAddress () {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    final addressStream = userCollection.doc(uid).collection('address').snapshots();
    return addressStream;
  }

  Future<void> deleteAddress (String docId) async {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    return await userCollection.doc(uid).collection('address').doc(docId).delete();
  }
}
