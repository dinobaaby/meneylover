import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneylover/models/user.model.dart' as model;
import 'package:uuid/uuid.dart';

import '../models/currency.model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<model.User> getUserDetails() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot snap = await _firestore.collection("usersc").doc(currentUser.uid).get();
      return model.User.fromSnap(snap);
    } else {
      throw Exception("Current user is null.");
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String res = "Some errer occurred";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      model.User user = model.User(
          uid: cred.user!.uid, email: email, money: 0, currencyId: "");

      await _firestore
          .collection("usersc")
          .doc(cred.user!.uid)
          .set(user.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> updateCurrencyIdByEmail(String email, [String currencyId = '298ee3d0-3585-1f4d-8480-7915cc360088']) async {
    String res = "Some error occurred";
    try{
      final querySnapshot = await _firestore.collection('usersc').where('email', isEqualTo: email).get();

      final docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        final userDoc = docs.first;
        final userData = userDoc.data() as Map<String, dynamic>;
        Currency oldcurrency = await fetchCurrencyInfo(userData["currencyId"]);
        Currency newcurrency = await fetchCurrencyInfo(currencyId);
        double money = (userData["money"] * oldcurrency.exchangeRate) / newcurrency.exchangeRate;
        await userDoc.reference.update({'currencyId': currencyId, 'money': money});
      } else {
        res = 'User with email $email not found';
      }
      res ='success';
    }catch(e){
      print("Error: " + e.toString());
      res = e.toString();
    }

    return res;
  }
  // Future<String> updateCurrencyIdByEmail(String email, [String currencyId = '298ee3d0-3585-1f4d-8480-7915cc360088']) async {
  //   String res = "Some error occurred";
  //   try {
  //     // Lấy thông tin người dùng từ Firestore
  //     final querySnapshot = await _firestore.collection('usersc').where('email', isEqualTo: email).get();
  //     final docs = querySnapshot.docs;
  //
  //     if (docs.isNotEmpty) {
  //       final userDoc = docs.first;
  //       final userData = userDoc.data() as Map<String, dynamic>;
  //
  //       double currentUserMoney = userData['money'];
  //
  //       Currency oldCurrency = await fetchCurrencyInfo(userData["currencyId"]);
  //       Currency newCurrencyInfo = await fetchCurrencyInfo(currencyId);
  //       double newExchangeRate = newCurrencyInfo.exchangeRate;
  //
  //       // Tính toán số tiền mới dựa trên tỷ giá hối đoái mới và số tiền hiện tại
  //       double newMoney = currentUserMoney * oldCurrency.exchangeRate / newExchangeRate;
  //
  //       // Cập nhật số tiền mới vào Firestore
  //       await userDoc.reference.update({'currencyId': currencyId, 'money': newMoney});
  //
  //       res = 'success';
  //     } else {
  //       res = 'User with email $email not found';
  //     }
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //
  //   return res;
  // }
  //
  Future<Currency> fetchCurrencyInfo(String currencyId) async {
    final doc = await _firestore.collection('currencys').doc(currencyId).get();
    if (doc.exists) {
      return Currency.fromSnap(doc);
    } else {
      throw Exception('Currency with ID $currencyId not found');
    }
  }
  //
  //



  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }


  Future<String> createCurrency(String userId, double money, [String categoryName = "Thu nhap", int category = 2]) async {
    String res = "Some error occurred";
    try {
      String categoryId = const Uuid().v1();
      await _firestore.collection("usersc").doc(userId).collection("moneys").doc(categoryId).set(
        {
          "uid": userId,
          "money": money,
          "categoryId": categoryId,
          "category": category,
          "thunhap": categoryName,
          "created": DateTime.now(),
        },
      );

      // Lấy thông tin người dùng từ Firestore
      DocumentSnapshot userSnapshot = await _firestore.collection('usersc').doc(userId).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

        // Lấy số tiền hiện tại của người dùng
        double currentUserMoney = (userData['money'] ?? 0).toDouble();


        // Cập nhật số tiền dựa vào category
        if (category == 1) {
          // Trừ tiền nếu category = 1
          currentUserMoney -= money;
        } else {
          // Cộng tiền nếu category khác 1
          currentUserMoney += money;
        }

        // Cập nhật dữ liệu người dùng với số tiền mới
        await _firestore.collection("usersc").doc(userId).update({"money": currentUserMoney});

        res = 'success';
      } else {
        res = 'User not found';
      }
    } catch (e) {
      print(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<double> calculateTotalWithCategory1(String userId) async {
    double total = 0;
    try {
      // Lấy tất cả các giao dịch có category = 1 của người dùng từ Firestore
      QuerySnapshot transactionsSnapshot = await _firestore
          .collection('usersc')
          .doc(userId)
          .collection('moneys')
          .where('category', isEqualTo: 1)
          .get();

      // Lặp qua từng giao dịch và tính tổng giá trị
      transactionsSnapshot.docs.forEach((transaction) {
        // Cast result of data() to Map<String, dynamic>
        final Map<String, dynamic>? transactionData = transaction.data() as Map<String, dynamic>?;

        // Check if transactionData is not null and contains 'money' key
        if (transactionData != null && transactionData.containsKey('money')) {
          total -= (transactionData['money'] as double?) ?? 0; // Trừ tiền với category = 1
        }
      });

    } catch (e) {
      // Xử lý nếu có lỗi xảy ra
      print('Error calculating total with category 1: $e');
    }

    return total;
  }

}
