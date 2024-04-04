

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/models/currency.model.dart';
import 'package:moneylover/models/user.model.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:moneylover/widgets/my_wallet_widget.dart';
import 'package:moneylover/widgets/speding_overview_widget.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final Currency currency = Provider.of<UserProvider>(context).getCurrency;

    return SafeArea(
          child:  Container(
            decoration: const BoxDecoration(
              color: Colors.black
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${user.money.toStringAsFixed(3)} ${currency.currencyName}",overflow: TextOverflow.ellipsis,maxLines: 1, style: const TextStyle(fontSize: 30, color: Colors.white),),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 5, left: 10),
                                  child: const Icon(Icons.remove_red_eye_rounded, color: Colors.white, ))
                            ],
                          ),
                          const Text("Tổng số dư", style: TextStyle(color: Colors.grey, fontSize: 17),)
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.notifications, color: Colors.white,))
                    ],
              
                  ),
                  const MyWalletWidget(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Báo cáo chi tiêu", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),),
                      Text("Xem báo cáo", style: TextStyle(color: Colors.green, fontSize: 17,
                          fontWeight: FontWeight.w600),)
                    ],
                  ),
                  const SpendingOverview()
                ],
              ),
            ),
          ),

    );
  }
}
