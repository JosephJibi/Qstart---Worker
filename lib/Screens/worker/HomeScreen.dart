import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Widgets/cardsForListOfComplaint.dart';
import '../../controller/AuthController.dart';
import '../../utilities/Dimensions.dart';
import '../../utilities/color.dart';
import 'DetailsPage.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   
final auth = FirebaseAuth.instance;
final ctrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor().secondGradient,
      ),
      child: Column(children: [
        //first container(main 1)
        Container(
          height: (ctrl.profiledata['complaint'] == 0) ? Dimensions.height280 : Dimensions.height230,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: AppColor().mainGradient,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
             SizedBox(
              height: Dimensions.height70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Dimensions.height120,
                  width: Dimensions.width120,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                 Text(
                  'QSTART',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 77, 82, 89),
                      letterSpacing: Dimensions.height2,
                      fontSize: Dimensions.height40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amaranth-Bold'),
                )
              ],
            ),
          ]),
        ),
        //second container
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height30),
                    topRight: Radius.circular(Dimensions.height30),
                  ),
                  boxShadow:  [
                    BoxShadow(
                      color: const Color.fromARGB(255, 97, 85, 85),
                      spreadRadius: Dimensions.height07,
                      blurRadius: Dimensions.height15,
                    )
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
                          .orderBy('date',descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print('working');
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return ListView(
                            children: snapshot.data!.docs.map((document) {
                              print('working2');
                             
                              print('complaint =');
                              print('${ctrl.profiledata['complaint']}');
                              if (ctrl.profiledata['totalcomplaintcount'] == 0) {
                              
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