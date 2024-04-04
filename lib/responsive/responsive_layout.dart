
import 'package:flutter/material.dart';
import 'package:moneylover/models/currency.model.dart';
import 'package:moneylover/providers/currency_provider.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';




class ResponsiveLayout extends StatefulWidget{
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    await _userProvider.fetchCurrency(_userProvider.getUser.currencyId);

    await _userProvider.fetchCurrency(_userProvider.getUser.currencyId);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth > 800){
            return widget.webScreenLayout;
          }
          return widget.mobileScreenLayout;
        }
    );
  }
}