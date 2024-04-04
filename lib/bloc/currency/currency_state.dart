
part of 'currency_bloc.dart';

sealed class CurrencyState{}

final class CurrencyInitialState extends CurrencyState{}

final class CurrencySuccess extends CurrencyState{
  final Currency currency;
  CurrencySuccess({required this.currency});

}


final class CurrencyFailure extends CurrencyState{
  final String error;
  CurrencyFailure({required this.error});
}

final class CurrencyLoading extends CurrencyState{}
