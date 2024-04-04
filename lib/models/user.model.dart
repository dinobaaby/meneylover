import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String uid;
  final String email;
  final double money;
  final String currencyId;



  const User({
    required this.uid,
    required this.email,
    required this.money,
    required this.currencyId,
  });

  Map<String, dynamic> toJson() =>{
    "uid": uid,
    "email": email,
    "money": money,
    "currencyId": currencyId,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      money: snapshot['money'],
      currencyId: snapshot['currencyId'],
    );
  }

}