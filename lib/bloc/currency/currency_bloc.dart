
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/currency.model.dart';
part 'currency_event.dart';
part 'currency_state.dart';


class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState>{
  CurrencyBloc() : super(CurrencyInitialState()){
    
  }
}