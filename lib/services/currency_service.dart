

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneylover/models/currency.model.dart';
import 'package:moneylover/services/storage_services.dart';
import 'package:uuid/uuid.dart';


class CurrencyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Currency> getCurrencyDetails(String currencyId) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      if (currencyId == "") {
        DocumentSnapshot snap1 = await _firestore
            .collection("currencys")
            .doc("298ee3d0-3585-1f4d-8480-7915cc360088") 
            .get();
        return Currency.fromSnap(snap1);
      } else {
        DocumentSnapshot snap = await _firestore
            .collection("currencys")
            .doc(currencyId)
            .get();
        return Currency.fromSnap(snap);
      }
    } else {
      throw Exception("Current user is null.");
    }
  }


  Future<String> uploadCurrency(
    String currencyName,
    String countryName,
    Uint8List file, double exchangeRateValue,
  ) async {
    String res = "Some error occurred";
    try{
      String photoUrl = await StorageService().uploadImage(file, "currencys", true);
      String currencyId = const Uuid().v1();
      Currency currency = Currency(
          currencyId: currencyId,
          currencyName: currencyName,
          countryName: countryName,
          countryImg: photoUrl,
          exchangeRate: exchangeRateValue
      );
      _firestore.collection("currencys").doc(currencyId).set(currency.toJson());
     res = "ss";


    }catch(e){
      res = e.toString();
    }

    return res;
  }

  Stream<List<Currency>> getAllCurrency() {
    return _firestore.collection("currencys").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Currency.fromSnap(doc)).toList();
    });
  }
}
