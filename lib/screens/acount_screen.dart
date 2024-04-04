import 'package:flutter/material.dart';
import 'package:moneylover/models/user.model.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:moneylover/screens/currency_list_screen.dart';
import 'package:moneylover/services/auth_service.dart';
import 'package:provider/provider.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({super.key});

  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Account", style: TextStyle(color: Colors.white),),
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            actions: [
              IconButton(onPressed: (){AuthService().signOut();}, icon: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white,))
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () async{

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CurrencyListScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("Đổi tiền", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
