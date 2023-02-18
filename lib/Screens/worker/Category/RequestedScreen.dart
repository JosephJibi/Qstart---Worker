import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qstart_worker/utilities/Dimensions.dart';

import '../../../Widgets/cardsForListOfComplaint.dart';
import '../../../controller/AuthController.dart';

//requested means work that is accepted by admin but worker not look it
class RequestedScreen extends StatelessWidget {
   RequestedScreen({super.key});

final auth = FirebaseAuth.instance;
final ctrl = Get.put(AuthController());
var flag=0;

  @override
  Widget build(BuildContext context) {
    var flag=0;
    var total = ctrl.profiledata['totalcomplaintcount'] -ctrl.profiledata['pendingcount'] -ctrl.profiledata['donecount'];

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
                if (total == 0 && flag==0) {
                  flag++;
                  return Column(
                    children: [
                      Container(
                          height: Dimensions.height280,
                          child: Lottie.network(
                                          // 'https://assets6.lottiefiles.com/packages/lf20_zfnngl5k.json',
                                          'https://assets2.lottiefiles.com/packages/lf20_fmieo0wt.json',
                                          // repeat: false,
                                          fit: BoxFit.contain),),
                      Text(
                        'No requested \n  complaints',
                        style: GoogleFonts.poppins(
                            fontSize: Dimensions.height15,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  );
                }
               if (document['status']=='Processing' && document['workerid'] ==
                                  auth.currentUser?.uid){
                     return cardsForListOfComplaint(document);
               }
               else{
                return SizedBox();
               }
               
              
              }).toList(),
            );
          }),
    );
  }
}