import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/widgets/currency_item_widget.dart';

import '../models/currency.model.dart';

class CurrencyListScreen extends StatefulWidget {

  const CurrencyListScreen({super.key});

  @override
  State<CurrencyListScreen> createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Đơn vị tiền tệ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          centerTitle: false,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1), // Chiều cao của border dưới
            child: Container(
              color: Colors.grey, // Màu sắc của border dưới
              height: 1, // Độ dày của border dưới
            ),
          ),

        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("currencys").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>  Container(
                    child: CurrencyItemWidget(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
