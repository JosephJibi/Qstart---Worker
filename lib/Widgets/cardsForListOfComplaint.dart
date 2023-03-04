import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/worker/DetailsPage.dart';
import '../utilities/Dimensions.dart';
import '../utilities/color.dart';

//changed cards builded using containers to method for ux it will change when actual database is added

GestureDetector cardsForListOfComplaint(QueryDocumentSnapshot document) {
  return GestureDetector(
      onTap: () {
        Get.to(DetailsPage(document));
      },
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height8),
        child: Container(
          height: Dimensions.height150,
          width: Dimensions.width380,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.height30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  // spreadRadius: 0.7,
                  blurRadius: Dimensions.height10,
                  offset: Offset(2, -2))
            ],
            color: Colors.white,
            // border: Border.all(
            //     color: const Color.fromARGB(255, 159, 186, 218), width: Dimensions.height1),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.height20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        document['title'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.height20),
                      ),
                      const Spacer(),
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
                                            : (document['status'] == 'Verified')
                                                ? AppColor.doneVerifiedColour
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
                                          : (document['status'] == 'Declined')
                                              ? AppColor.declainedtextColour
                                              : (document['status'] ==
                                                      'Pending')
                                                  ? AppColor.pendingtextColour
                                                  : (document['status'] ==
                                                          'Verified')
                                                      ? AppColor
                                                          .doneVerifiedColour
                                                      : AppColor
                                                          .donetextColour),
                            ),
                          )),
                    ],
                  ),
                  //sizedbox between title row and description
                  SizedBox(
                    height: Dimensions.height5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // document['description'].substring(0,45)
                        // +'...'
                        document['description'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      Divider(
                        thickness: Dimensions.height1,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              document['locationhint'],
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(),
                            ),
                            const Spacer(),
                            VerticalDivider(
                              // color: Colors.black,  //color of divider
                              // width: 10, //width space of divider
                              thickness:
                                  Dimensions.height2, //thickness of divier line
                              // indent: 1, //Spacing at the top of divider.
                              // endIndent: 1, //Spacing at the bottom of divider.
                            ),
                            const Icon(Icons.calendar_month_outlined),
                            SizedBox(
                              width: Dimensions.width5,
                            ),
                            Text(
                              document['date'],
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ));
}
