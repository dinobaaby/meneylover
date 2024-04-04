
import 'package:flutter/cupertino.dart';
import '../models/currency.model.dart';
import '../models/user.model.dart';
import '../services/auth_service.dart';
import '../services/currency_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthService _authMethods = AuthService();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
  Currency? _currency;
  final CurrencyService _currencyService = CurrencyService();

  Currency get getCurrency => _currency!;

  Future<void> fetchCurrency(currencyId) async {
    Currency currency = await _currencyService.getCurrencyDetails(currencyId);
    _currency = currency;
    notifyListeners();
  }

}