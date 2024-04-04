import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneylover/utils/screens.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTaped(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: PageView(
            children: screenMenus,
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: onPageChanged,
          ),
          bottomNavigationBar: CupertinoTabBar(
            height: 65,
            backgroundColor: Colors.black87,
            items: [
              bottomNavigationBarItemMethod(0, Icons.home),
              bottomNavigationBarItemMethod(1, Icons.money),
              bottomNavigationBarItemMethod(2, Icons.add_circle),
              bottomNavigationBarItemMethod(3, Icons.account_balance_wallet_rounded),
              bottomNavigationBarItemMethod(4, Icons.person),
            ],
            onTap: navigationTaped,
          ),
        )
    );
  }
  BottomNavigationBarItem bottomNavigationBarItemMethod(int page, IconData iconItem){
    return BottomNavigationBarItem(
        icon: Icon(
          iconItem,
          color: _page == page? Colors.blue: Colors.grey,
          size: page == 2 ? 40 : 30,
        ),
        backgroundColor: page == 2 ? Colors.greenAccent : Colors.grey
    );
  }


}
