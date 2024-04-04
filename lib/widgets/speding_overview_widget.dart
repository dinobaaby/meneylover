import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneylover/models/currency.model.dart';
import 'package:moneylover/models/user.model.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:moneylover/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'category_widget.dart';

class SpendingOverview extends StatefulWidget {
  const SpendingOverview({super.key});

  @override
  State<SpendingOverview> createState() => _SpendingOverviewState();
}

class _SpendingOverviewState extends State<SpendingOverview> {
  final List<Map<String, dynamic>> _selectedOption = [
    {
      'title': 'Tuần',
      'value': 'week',
    },
    {
      'title': 'Tháng',
      'value': 'month',
    }
  ];
  int _selectedInitial = 0;
  double _total = 0;
  @override
  void initState() {

    super.initState();

  }

  getData(userID) async {
    double total = await AuthService().calculateTotalWithCategory1(userID);
    _total = total;
  }
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final Currency crr = Provider.of<UserProvider>(context).getCurrency;
    getData(user.uid);



    return Container(

      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Container(
               height: 40,
               padding: const EdgeInsets.all(3),
               decoration: BoxDecoration(
                 color: Colors.grey[800],
                 borderRadius: BorderRadius.circular(5)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            _selectedInitial = 0;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _selectedInitial == 0 ? Colors.grey[700] : Colors.grey[800],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('${_selectedOption[0]["title"]}', style: TextStyle(color: _selectedInitial == 0 ? Colors.white :  Colors.grey, fontSize: 17, ),),
                        )
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          _selectedInitial = 1;
                        });
                      },
                        child: Container(

                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:  _selectedInitial == 1 ? Colors.grey[700] : Colors.grey[800],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text("${_selectedOption[1]["title"]}", style:  TextStyle(color:_selectedInitial == 1 ? Colors.white :  Colors.grey, fontSize: 17),),
                        )
                    ),
                  )

                ],
                           ),
             ),
            const SizedBox(height: 10,),
             Row(
              children: [
                Text("${user.money.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28),),
                Text(" ${crr.currencyName}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28))
              ],
            ),
          Row(
            children: [
              const Text("Tổng chi tháng này", style: TextStyle(color: Colors.grey),),
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange
                ),
                alignment: Alignment.center,
                child: const Text("-", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
              ),
              Container(

                alignment: Alignment.center,
                child: Text("${_total} ${crr.currencyName}", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: _selectedInitial == 0 ? 130 : 100,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                  ),
                ),
                Container(
                  width: 60,
                  height: _selectedInitial == 1 ? 130 : 100,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("${_selectedOption[_selectedInitial]["title"]} trước", style: const TextStyle(color: Colors.grey),),
                    Text("${_selectedOption[_selectedInitial]["title"]} này", style: const TextStyle(color: Colors.grey),),
                  ],
                )
              ],
            )
          ),
          const SizedBox(height: 10,),
           Row(
            children: [
              const Text("Chi tiêu nhiều nhất", style: TextStyle(color: Colors.grey, fontSize: 15),),
              Container(
                width: 45,
                height: 25,
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Text("Ví dụ", style: TextStyle(color: Colors.white, fontSize: 12),),
              )
            ],
          ),
          const CategoryWidget(imageUrl: "https://scontent.fhan15-2.fna.fbcdn.net/v/t39.30808-6/434892477_452487523875124_1215378422203928148_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEhmbrVdKQAhwYZQJKj-kD6MT5l7wxxzkIxPmXvDHHOQrwNyw_ccWzjMUB-b8mLpL2vdq1-zHjMX-exr3AC_h7a&_nc_ohc=gTw2eEpyDWIAb55y2gT&_nc_ht=scontent.fhan15-2.fna&oh=00_AfD8QWVuNMIeGPeeimr4A_uYbMEUJOpZVBxylU7FEo4cmA&oe=6614B51B",title: "Food & Beverage",subtitle: "80%",),
          const CategoryWidget(imageUrl: "https://scontent.fhan15-1.fna.fbcdn.net/v/t39.30808-6/434748174_398667722949053_4078445516733783128_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFjepVTrX2XVHkMEXZLqB0lFbNUYUfIOaAVs1RhR8g5oONUG_dntuxZtkSXnWjxdcv4v-nuGS-jvims9dYa_PX5&_nc_ohc=T4IEfCTF1vgAb4dCKjB&_nc_ht=scontent.fhan15-1.fna&oh=00_AfBA5r1Y3eccjHeeLE2NAOnQwKcerHBq65zQW-GslaEZbQ&oe=6614BE04",title: "Rental",subtitle: "15%",),
          const CategoryWidget(imageUrl: "https://scontent.fhan15-2.fna.fbcdn.net/v/t39.30808-6/434329720_1117202549316686_2513975067224233962_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEVb6UIIdEZ4psSC4UrKxQzy72XblZKZvLLvZduVkpm8pEUYQQqiflNq5u5faflXjlU-6rv5PfSYq3rrnh-wohn&_nc_ohc=deSl77bgSzoAb5vI9Jd&_nc_ht=scontent.fhan15-2.fna&oh=00_AfBIkTo49CLq-RwrC-N9K7cZUfchn83MAEz-Z6PqLsXw1w&oe=6614A302",title: "Shopping",subtitle: "5%",)


        ],

      ),
    );
  }
}
