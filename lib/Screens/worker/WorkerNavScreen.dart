import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qstart_worker/Screens/worker/Category/CategoryScreen.dart';
import 'package:qstart_worker/Screens/worker/HomeScreen.dart';
import 'package:qstart_worker/Screens/worker/ProfileScreen.dart';

import '../../utilities/Dimensions.dart';

class WorkerNavScreen extends StatefulWidget {
  const WorkerNavScreen({super.key});

  @override
  State<WorkerNavScreen> createState() => _WorkerNavScreenState();
}

class _WorkerNavScreenState extends State<WorkerNavScreen> {
   int index = 0;
  final _pages = [
     HomeScreen(),
     CategoryScreen(),
     ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _pages[index],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.height15,vertical: Dimensions.height20),
          child: GNav(
            onTabChange: (value) {
              print(value);
              setState(() {
                index=value;
              });
            },
            gap: Dimensions.height8,
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundGradient: LinearGradient(
                           colors: [Colors.blue.shade400,Colors.blue.shade300, Colors.blue.shade200],
                           begin: Alignment.bottomLeft,
                           end: Alignment.topRight),
            padding: EdgeInsets.all(Dimensions.height16),
             tabBorderRadius: Dimensions.height15, 
            tabs: [
            GButton(icon: Icons.home,
            text: 'Home',),
            GButton(icon: Icons.category,
            text: 'Category',
            ),
            GButton(icon: Icons.person,
            text: 'Profile',
            ),
          ]),
        ),
      ),
    );
  }
}