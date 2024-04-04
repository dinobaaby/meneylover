


import 'package:flutter/cupertino.dart';

import 'package:moneylover/services/currency_service.dart';


import '../models/currency.model.dart';


class CurrencyProvider with ChangeNotifier{
  Currency? _currency;
  final CurrencyService _currencyService = CurrencyService();

  Currency get getCurrency => _currency!;

  Future<void> fetchCurrency(currencyId) async {
    Currency currency = await _currencyService.getCurrencyDetails(currencyId);
    _currency = currency;
    notifyListeners();
  }
}