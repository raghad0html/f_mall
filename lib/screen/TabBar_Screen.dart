import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:moll_app/screen/drawer/whowe%20are.dart';
import 'package:moll_app/screen/profile/profile.dart';
import 'package:moll_app/screen/welcomAfterlogin.dart';

import 'Search/Search.dart';
import 'drawer/drawer.dart';
import 'notification.dart';
import 'scan.dart';

class TabBar_Screen extends StatefulWidget {
  final int user_id;
  final user_data;
  const TabBar_Screen({Key? key, required this.user_id, this.user_data}) : super(key: key);
  @override
  _TabBar_ScreenState createState() => _TabBar_ScreenState();
}

class _TabBar_ScreenState extends State<TabBar_Screen> {
  final bool appeer = false;
  final iconList = <IconData>[
    Icons.home,
    Icons.info_outline,
    Icons.notification_important_sharp,
    Icons.person,
  ];
  late final List<Map<String, Widget>> pages;
  late final List<Map<String, String>> title;
  int selectedIndex = 0;
  @override
  void initState() {
    pages = [
      {
        'page': WelcomeAfterScreen(),
      },
      {
        'page': WhoWeAre(),
      },
      {
        'page': notifiction(
          user_id: widget.user_id,
        ),
      },
      {
        'page': profile(
          user_data:widget.user_data,
        ),
      },
    ];
    title = [
      {
        'title': 'الرئسية',
      },
      {
        'title': 'من نحن',
      },
      {
        'title': 'الإشعارات',
      },
      {
        'title': 'حول',
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => QRViewExample(id: widget.user_id)));
          },
          child: Icon(Icons.qr_code),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: buildAppBar(title),
        drawer: MainDrawer(
          user_data: widget.user_data,
        ),
        body: pages[selectedIndex]['page'],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          backgroundColor:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.black12
                  : Colors.white,
          activeIndex: selectedIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          activeColor: Colors.teal,
          inactiveColor:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey,
          onTap: (index) => setState(() => selectedIndex = index),
        ),
      ),
    );
  }

  AppBar buildAppBar(title) {
    return AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: true,
        title: Text(title[selectedIndex]['title']),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => search()));
            },
            icon: Icon(Icons.search),
          ),
          // PopupMenuButton<String>(onSelected: (itemIdentifire) {
          //   if (itemIdentifire == 'Logout') {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (builder) => LoginScreen()));
          //   }
          //   if (itemIdentifire == 'Setting') {}
          // }, itemBuilder: (BuildContext context) {
          //   return [
          //     PopupMenuItem(
          //       child: Text('تسجيل الخروج'),
          //       value: 'Logout',
          //     ),
          //     PopupMenuItem(
          //       child: Text('الإعدادات'),
          //       value: 'Setting',
          //     ),
          //   ];
          // }),
        ]);
  }
}
