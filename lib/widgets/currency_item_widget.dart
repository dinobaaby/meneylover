import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneylover/models/user.model.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/main.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:moneylover/responsive/mobile_screen_layout.dart';
import 'package:moneylover/responsive/responsive_layout.dart';
import 'package:moneylover/responsive/web_screen_layout.dart';
import 'package:moneylover/screens/home_screen.dart';
import 'package:moneylover/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CurrencyItemWidget extends StatefulWidget {
  final snap;

  const CurrencyItemWidget({required this.snap, super.key});

  @override
  State<CurrencyItemWidget> createState() => _CurrencyItemWidgetState();
}

class _CurrencyItemWidgetState extends State<CurrencyItemWidget> {
 

  getData() async{
    
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    await _userProvider.fetchCurrency(_userProvider.getUser.currencyId);
   
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return InkWell(
      onTap: () async{
        await AuthService().updateCurrencyIdByEmail(user.email, widget.snap["currencyId"]);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())));

      },

      child: Container(
        width: double.infinity,
        height: 85,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${widget.snap["countryImg"]}'),
                  fit: BoxFit.cover
                )
              ),
            ),
            Flexible(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: 500,

                decoration:  const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black12, width: 1),
                    bottom: BorderSide(color: Colors.black12, width: 1),

                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.snap["countryName"].toString(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
                    Text(widget.snap["currencyName"].toString()),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
