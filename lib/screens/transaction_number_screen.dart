import 'package:flutter/material.dart';

class TransactionNumberScreen extends StatefulWidget {
  const TransactionNumberScreen({super.key});

  @override
  State<TransactionNumberScreen> createState() => _TransactionNumberScreenState();
}

class _TransactionNumberScreenState extends State<TransactionNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text("TransactionNumber Screen"),
          ),
        )
    );
  }
}
