import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/screens/currency_list_screen.dart';
import 'package:moneylover/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.model.dart';
import '../providers/user_provider.dart';



class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
   String _email = "";

  getData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email =  prefs.getString("email");
    setState(() {
      _email = email ?? "" ;
    });

  }
  @override
  void initState() {
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {



    return  SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 30,),

              const Text("Chọn đơn vị tiền tệ mà bạn sử dụng", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
              const SizedBox(height: 10,),
              const Text("Bạn có thể thay đổi sang đơn vị tiền khác bất cứ lúc nào", style: TextStyle(
                color: Colors.grey,
                fontSize: 14,

                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60,),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrencyListScreen())),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(173, 165, 165, 0.5)
                    )
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/800px-Flag_of_Vietnam.svg.png"),
                                fit: BoxFit.cover,
                              )
                
                            ),
                          ),
                
                          const Text("Việt Nam Đồng", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                        ],
                      ),
                      InkWell(
                        onTap: (){},
                        child: const Text("SỬA", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                
                ),
              ),
              Flexible(flex: 5, child: Container()),
              InkWell(
                  onTap: (){
                    AuthService().updateCurrencyIdByEmail(_email);
                  },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Text("Tiếp tục", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),),
                    ),
               )


            ],
          
          ),
        ),

      ),
    );
  }
}
