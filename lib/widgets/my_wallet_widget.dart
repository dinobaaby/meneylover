
import 'package:flutter/material.dart';
import 'package:moneylover/models/currency.model.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/user.model.dart';

class MyWalletWidget extends StatelessWidget {
  const MyWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final Currency currency = Provider.of<UserProvider>(context).getCurrency;
    return Container(
      width: double.infinity,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ví của tôi", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              Text("Xem tất cả", style: TextStyle(color: Colors.green, fontSize: 18,
               fontWeight: FontWeight.w600),)
            ],
          ),
          Divider(color: Colors.grey[800],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/wallet.png")
                      ),
                      borderRadius: BorderRadius.circular(18)
                    ),
                  ),
                  const Text("Tiền mặt", style: TextStyle(color: Colors.white, fontSize: 18),),


                ],
              ),
              Text("${user.money.toStringAsFixed(3)} ${currency.currencyName}", style: const TextStyle(color: Colors.white, fontSize: 18, ))            ],
          )
        ],
      ),
    );
  }
}
