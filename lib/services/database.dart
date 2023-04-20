import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData(
      String name,
      String imageUrl,
      String mobileNumber,
      String email,
      String dob ) async {
    return await usersCollection.doc(uid).set({
      'userName': name,
      'mobileNo': mobileNumber,
      'email': email,
      'dob': dob,
      'imageUrl': imageUrl,
    });
  }
  Stream<DocumentSnapshot> get user {
    return usersCollection.doc(uid).snapshots();
  }
}