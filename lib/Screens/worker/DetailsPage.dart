import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_worker/Widgets/DonePopup.dart';
import 'package:qstart_worker/Widgets/PendingPopup.dart';

import '../../utilities/Dimensions.dart';
import '../../utilities/color.dart';

class DetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot document;
  const DetailsPage(this.document, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //image uploaded by user
        FadeInImage(
          image: NetworkImage(
            document['img'],
          ),
          placeholder: const AssetImage('assets/images/loading.gif'),
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        //row for icons(close screen, delete item)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //close button
            IconButton(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: Dimensions.height98, left: Dimensions.width20),
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                    // Icons.close,
                    size: Dimensions.height30,
                    FontAwesomeIcons.xmark)),
          ],
        ),
        //bottom part
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 2.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.height45),
                  // topRight: Radius.circular(40)
                )),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.height30,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //row to hold complaint date and status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //define date of complaint
                          const Icon(Icons.calendar_month_outlined),
                          Text(
                            document['date'],
                            style: GoogleFonts.poppins(),
                          ),
                          const Spacer(),
                          //container for display work status
                          Text(
                            'Current Status :    ',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.height50)),
                                color: (document['status'] == 'Requested')
                                    ? AppColor.requestedColour
                                    : (document['status'] == 'Processing')
                                        ? AppColor.processingColour
                                        : (document['status'] == 'Declined')
                                            ? AppColor.declainedColour
                                            : (document['status'] == 'Pending')
                                                ? AppColor.pendingColour
                                                : (document['status'] ==
                                                        'Verified')
                                                    ? AppColor
                                                        .doneVerifiedColour
                                                    : AppColor.doneColour,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height5),
                                child: Text(
                                  document['status'],
                                  style: GoogleFonts.poppins(
                                      color: (document['status'] == 'Requested')
                                          ? AppColor.requestedtextColour
                                          : (document['status'] == 'Processing')
                                              ? AppColor.processingtextColour
                                              : (document['status'] ==
                                                      'Declined')
                                                  ? AppColor.declainedtextColour
                                                  : (document['status'] ==
                                                          'Pending')
                                                      ? AppColor
                                                          .pendingtextColour
                                                      : (document['status'] ==
                                                              'Verified')
                                                          ? AppColor
                                                              .doneVerifiedtextColour
                                                          : AppColor
                                                              .donetextColour),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //heading - title of complaint
                      Text(
                        document['title'],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: Dimensions.height30),
                      ),
                      //location hint of complaint
                      Text(
                        document['locationhint'],
                        style: GoogleFonts.poppins(
                            fontSize: Dimensions.height20,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.access_time_sharp),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Text(
                            document['time'],
                            style: GoogleFonts.poppins(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Text(
                        'Description :  ' + document['description'],
                        // 'We have been using this purifier from our 1st yr. It\'s not working from last 3 days. Do check on this and ensure it\'s working ',
                        style: GoogleFonts.poppins(
                          fontSize: Dimensions.height15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      //
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //row for Done ,Pending,declined buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Done
                          if (document['status'] == 'Processing' ||
                              document['status'] == 'Pending')
                            GestureDetector(
                              onTap: () {
                                DonepopUpBox(
                                    context, document.id, document['status']);
                              },
                              //done
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.height10)),
                                    color: Colors.lightBlueAccent),
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height10),
                                  // child: Text(document['status']),
                                  child: Text(
                                    'Work is completed',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: Dimensions.height40,
                          ),
                          //Pending
                          if (document['status'] == 'Processing' &&
                              document['status'] != 'Done' &&
                              document['status'] != 'Verified')
                            GestureDetector(
                              onTap: () {
                                pendingPopup(context, document.id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.height10)),
                                    color: Colors.redAccent),
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height8),
                                  // child: Text(document['status']),
                                  child: Text(
                                    'Work is pending',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
