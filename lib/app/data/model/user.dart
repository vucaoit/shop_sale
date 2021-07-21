import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id='';
  String name='';
  String email='';

  UserModel({required this.id,required this.name,required this.email});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
  }
}