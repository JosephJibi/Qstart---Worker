import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../utilities/Dimensions.dart';
import 'Category/CategoryScreen.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';

class WorkerNavScreen extends StatefulWidget {
  const WorkerNavScreen({super.key});

  @override
  State<WorkerNavScreen> createState() => _WorkerNavScreenState();
}

class _WorkerNavScreenState extends State<WorkerNavScreen> {
  int index = 2;
  final _pages = [
 HomeScreen(),
     CategoryScreen(),
     ProfileScreen(),  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: Dimensions.height30,
      ),
      Icon(
        Icons.category,
        size: Dimensions.height30,
      ),
      Icon(
        Icons.person,
        size: Dimensions.height30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 234, 228, 228),
      body: _pages[index],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: Dimensions.height60,
          index: index,
          items: items,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          }),
    );
  }
}
