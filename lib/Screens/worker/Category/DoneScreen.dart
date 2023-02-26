import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qstart_worker/Widgets/cardsForListOfComplaint.dart';

import '../../../controller/AuthController.dart';
import '../../../utilities/Dimensions.dart';

class DoneScreen extends StatelessWidget {
  DoneScreen({super.key});

  final auth = FirebaseAuth.instance;
  final ctrl = Get.put(AuthController());
  
  @override
  Widget build(BuildContext context) {
    var flag=0;
    return Container(
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('complaint').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return ListView(
         padding: EdgeInsets.only(top: Dimensions.height20),
              // physics: BouncingScrollPhysics(),
              // shrinkWrap: true,
              children: snapshot.data!.docs.map((document) {
                if (ctrl.profiledata['donecount'] == 0 && flag==0) {
                  flag++;
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
                        'You haven\'t done \n any complaints',
                          textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: Dimensions.height15,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  );
                }
                if (document['status'] == 'Done'  || document['status'] == 'Verified'&&
                    document['workerid'] == auth.currentUser?.uid) {
                  return cardsForListOfComplaint(document);
                } else {
                  return SizedBox();
                }
              }).toList(),
            );
          }),
    );
  }
}
