
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:moneylover/main.dart';
import 'package:moneylover/models/currency.model.dart';
import 'package:moneylover/models/user.model.dart';
import 'package:moneylover/providers/user_provider.dart';
import 'package:moneylover/responsive/mobile_screen_layout.dart';
import 'package:moneylover/responsive/responsive_layout.dart';
import 'package:moneylover/responsive/web_screen_layout.dart';
import 'package:moneylover/screens/category_screen.dart';
import 'package:moneylover/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _postController = TextEditingController();
  List<String>  fieldCategory = [];

  @override
  void initState() {
    super.initState();
    _postController.text = '0';
    getCategory();
  }

  @override
  void dispose() {
    super.dispose();
    _postController.dispose();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    await _userProvider.fetchCurrency(_userProvider.getUser.currencyId);
  }

  getCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('items');
    print(items);
    setState(() {
      if (items != null) {
        fieldCategory.add(items[0]);
        fieldCategory.add(items[1]);
        fieldCategory.add(items[2]);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final Currency currency = Provider.of<UserProvider>(context).getCurrency;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            leading: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp())),
              icon: const Icon(Icons.close, color: Colors.white,),

            ),
            title: const Text("Thêm giao dịch", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
          ),
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(

                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child:  Column(
                          children: [
                            TextField(
                              decoration:  const InputDecoration(
                                border:InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                prefixIcon: Icon(Icons.wallet, color: Colors.white,),
                              ),
                              controller: _postController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryScreen() )),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey
                                  ),

                                  child:fieldCategory.length <= 0 ? const Icon(Icons.question_mark, color: Colors.white,) : Image(image: NetworkImage(fieldCategory[2],), width: 40, fit: BoxFit.cover,)
                              ),
                              const SizedBox(width: 40,),
                              fieldCategory.length <= 0 ? const Text("Chọn nhóm", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),) :  Text(fieldCategory[0], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            const Icon(Icons.format_list_bulleted_outlined, color: Colors.white,),
                            Container(

                              width: 250,
                              margin: const EdgeInsets.only(top: 0, left: 40),
                              child: const TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Thêm ghi chu",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 20)
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.today, color: Colors.white,),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const Text("Hôm nay", style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.money, color: Colors.white,),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const Text("Tiền mặt", style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                Flexible(flex: 6,child: Container(),),
                InkWell(
                  onTap: () async{
                    if(fieldCategory.length > 0){
                      await AuthService().createCurrency(user.uid, double.parse(_postController.text), fieldCategory[0], int.parse(fieldCategory[1]) );
                    }else{
                      await AuthService().createCurrency(user.uid, double.parse(_postController.text) );
                    }
                    setState(() {
                      addData();
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: const Text("Thêm"),
                  ),
                )


              ],
            ),
          ),
        )
    );
  }
}
