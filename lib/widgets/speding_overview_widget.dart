import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  @override
  Widget build(BuildContext context) {
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

        ],

      ),
    );
  }
}
