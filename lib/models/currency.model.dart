

import 'package:cloud_firestore/cloud_firestore.dart';

class Currency{
  final String currencyId;
  final String currencyName;
  final String countryName;
  final String countryImg;
  final double exchangeRate;


  const Currency({
    required this.currencyId,
    required this.currencyName,
    required this.countryName,
    required this.countryImg,
    required this.exchangeRate,
  });

  Map<String, dynamic> toJson() =>{
    "currencyId" : currencyId,
    "currencyName" : currencyName,
    "countryName" : countryName,
    "countryImg" : countryImg,
    "exchangeRate" : exchangeRate
  };

  static Currency fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data()  as Map<String, dynamic>;

    return Currency(
        currencyId: snapshot["currencyId"],
        currencyName: snapshot["currencyName"],
        countryName: snapshot["countryName"],
        countryImg: snapshot["countryImg"],
        exchangeRate: double.parse(snapshot["exchangeRate"].toString())
    );
  }

}