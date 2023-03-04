import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Widgets/cardsForListOfComplaint.dart';
import '../../controller/AuthController.dart';
import '../../utilities/Dimensions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final auth = FirebaseAuth.instance;
  final ctrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // gradient: AppColor().secondGradient,
        image: DecorationImage(
            image: AssetImage("assets/images/background3.jpg"),
            fit: BoxFit.fill),
      ),
      child: Column(children: [
        //first container(main 1)
        Container(
          height: (ctrl.profiledata['complaint'] == 0)
              ? Dimensions.height280
              : Dimensions.height230,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            // gradient: AppColor().mainGradient,
            image: DecorationImage(
                image: AssetImage("assets/images/background3.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimensions.height10,
              ),
              // Container(
              //   height: Dimensions.height59,
              //   width: Dimensions.width90,
              //   child: Image.asset(
              //     'assets/images/logo.png',
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
                  fontSize: Dimensions.height30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        //second container
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
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
              //if complaint field of current user is null then we not need to use streambuilder because thatmeans user have not posted any complaints

              child:
                  //  (ctrl.profiledata['complaint'] == 0)
                  //     ?
                  //     //if not complaint has posted by currentuser then return a column
                  //     Column(
                  //         children: [
                  //           Container(
                  //             height: 280,
                  //             child: Lottie.network(
                  //                 // 'https://assets6.lottiefiles.com/packages/lf20_zfnngl5k.json',
                  //                 'https://assets2.lottiefiles.com/packages/lf20_fmieo0wt.json',
                  //                 // repeat: false,
                  //                 fit: BoxFit.contain),
                  //           ),
                  //           Text(
                  //             'You haven\'posted \n any complaints',
                  //             style: GoogleFonts.poppins(
                  //                 fontSize: 15, fontWeight: FontWeight.w500),
                  //           )
                  //         ],
                  //       ):
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('complaint')
                          .orderBy('date', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView(
                            padding: EdgeInsets.only(top: Dimensions.height25),
                            physics: const BouncingScrollPhysics(),
                            children: snapshot.data!.docs.map((document) {
                              if (ctrl.profiledata['totalcomplaintcount'] ==
                                  0) {
                                //   print(ctrl2.flag);
                                //  print('working');
                                //  print(ctrl.profiledata['complaint']);
                                return Column(
                                  children: [
                                    Container(
                                      height: Dimensions.height280,
                                      child: Lottie.network(
                                          // 'https://assets6.lottiefiles.com/packages/lf20_zfnngl5k.json',
                                          'https://assets2.lottiefiles.com/packages/lf20_fmieo0wt.json',
                                          // repeat: false,
                                          fit: BoxFit.contain),
                                    ),
                                    Text(
                                      'You haven\'t assigned \n any complaints',
                                      style: GoogleFonts.poppins(
                                          fontSize: Dimensions.height15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                );
                              }
                              if (document['workerid'] ==
                                  auth.currentUser?.uid) {
                                return cardsForListOfComplaint(document);
                              } else {
                                return const SizedBox();
                              }
                            }).toList(),
                          );
                        }
                      })),
        ),
      ]),
    );
  }
}
