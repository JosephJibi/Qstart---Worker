import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_worker/Screens/worker/Category/DoneScreen.dart';
import 'package:qstart_worker/Screens/worker/Category/PendingScreen.dart';
import 'package:qstart_worker/Screens/worker/Category/RequestedScreen.dart';
import 'package:qstart_worker/utilities/Dimensions.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //container for main background color
        decoration: const BoxDecoration(
          // gradient: AppColor().secondGradient
          image: DecorationImage(
              image: AssetImage("assets/images/background3.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(children: [
          //first container
          Container(
            //top most container having gradient background
            decoration: const BoxDecoration(
              // gradient: AppColor().mainGradient
              image: DecorationImage(
                  image: AssetImage("assets/images/background3.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(children: [
              SizedBox(
                height: Dimensions.height100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: Dimensions.height100,
                  //   width: Dimensions.width250,
                  //   child: Image.asset(
                  //     'assets/images/logotext.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Container(
                    height: Dimensions.height59,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/images/logo2.png",
                    ),
                  ),
                  Text(
                    'QSTART',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      letterSpacing: Dimensions.height2,
                      fontSize: Dimensions.height40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.height25,
              ),
            ]),
          ),
          //second container

          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height30),
                    topRight: Radius.circular(Dimensions.height30),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white24,
                        // spreadRadius: 0.7,
                        blurRadius: 10,
                        offset: Offset(2, -2))
                  ]),
              child: DefaultTabController(
                length: 3,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      // give the tab bar a height [can change hheight to preferred height]
                      Container(
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(
                            Dimensions.height25,
                          ),
                        ),
                        child: TabBar(
                          physics: const BouncingScrollPhysics(),
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.height25,
                            ),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade300,
                                  Colors.blue.shade200
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            // color: Colors.green,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          labelStyle: GoogleFonts.poppins(),
                          tabs: const [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                              text: 'Done',
                            ),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                              text: 'Pending',
                            ),
                            Tab(
                              text: 'Requested',
                            )
                          ],
                        ),
                      ),
                      // tab bar view here
                      Expanded(
                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // first tab bar view widget
                            DoneScreen(),

                            // second tab bar view widget
                            PendingScreen(),

                            //third tab bar view widget
                            RequestedScreen()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
