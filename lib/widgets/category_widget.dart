import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  const CategoryWidget({super.key, required this.title, required this.imageUrl, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(top: 15, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image:  DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Container(margin: const EdgeInsets.only(top: 10), child:  Text(title, style: const TextStyle(color: Colors.grey, fontSize: 17),))
            ],
          ),
          Container(margin: const EdgeInsets.only(top: 10),child: Text(subtitle, style: TextStyle(color: Colors.redAccent),))
        ],
      ),
    );
  }
}
