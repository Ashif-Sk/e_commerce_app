import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // User? user =  FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>?> getUserDetails () async {
    User? user = firebaseAuth.currentUser;
    Map<String, dynamic>? users;
     await firestore.collection('users').doc(user!.uid).get().then((snapshot){
       users= snapshot.data() as Map<String, dynamic>;
    });
    return users;
  }

  Future<void> deleteAddress (String docId) async {
    User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    return await userCollection.doc(uid).collection('address').doc(docId).delete();
  }
}