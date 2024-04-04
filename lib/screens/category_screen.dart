
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:moneylover/screens/add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selected = 0;
  List<Map<String, dynamic>> selectedOption = [
    {
      "value": 1 ,
      "name":"Khoản chi"
    },
    {
      "value": 2 ,
      "name":"Khoản thu"
    },
    {
      "value": 3 ,
      "name":"Khoản vay"
    }
  ];
  List<Map<String, dynamic>> filteredData = [];

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse('https://66002906df565f1a6145e560.mockapi.io/api/v1/cetegory'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> datas = data.where((item) => item['loai'] == selectedOption[_selected]["value"]).toList().cast<Map<String, dynamic>>();
      filteredData = datas;
      return datas;

    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text("Chọn nhóm", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: () {},
                icon: const Icon(Icons.filter_list, color: Colors.white,)),
            IconButton(
              onPressed: () {}, icon: const Icon(Icons.search), color: Colors.white,)
          ],
        ),
        body: Container(
          width: double.infinity,

          decoration: const BoxDecoration(
            color: Colors.black
          ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  border: Border.all(
                    color: Colors.grey,
                    width: 1
                  )
                ),
                child: Row(

                  children: [
                    Flexible(flex: 1, child: InkWell(
                      onTap: (){
                        setState(() {
                          _selected = 0;
                          fetchData();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: _selected == 0 ? 5 : 0,
                              color: Colors.white
                            )
                          )
                        ),
                        child:  Text("${selectedOption[0]["name"]}",
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),

                        ),
                      ),
                    )),
                    Flexible(flex: 1, child: InkWell(
                      onTap: (){
                        setState(() {
                          _selected = 1;
                          fetchData();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: _selected == 1 ? 5 : 0,
                                    color: Colors.white
                                )
                            )
                        ),
                        child:  Text("${selectedOption[1]["name"]}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                    )),
                    Flexible(flex: 1, child: InkWell(
                      onTap: (){
                        setState(() {
                          _selected = 2;
                          fetchData();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: _selected == 2 ? 5 : 0,
                                    color: Colors.white
                                )
                            )
                        ),
                        child:  Text("${selectedOption[2]["name"]}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 60,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[800]
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: const Icon(Icons.add_circle, color: Colors.green,),
                    ),
                    const Text("NHÓM MỚI", style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.w400),)
                  ],
                ),

              ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Container(
                    
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setStringList('items', <String>[
                              filteredData[index]['name'],
                              filteredData[index]['loai'].toString(),
                              filteredData[index]['image'].toString()
                            ]);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddScreen()));
                          },
                          child: Container(
                            color: Colors.grey[700],
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(

                              title: Text(filteredData[index]['name'], style: const TextStyle(color: Colors.white, fontSize: 20),),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  filteredData[index]['image'],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            )


            ],
          ),

        )


      ),
    );
  }
}
