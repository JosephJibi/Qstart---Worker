import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_worker/controller/ComplaintController.dart';
import '../utilities/Dimensions.dart';
import '../utilities/inputbox.dart';

//popup

final ctrl = Get.put(ComplaintController());
Future pendingPopup(BuildContext ctx, var complaintid) async {
  return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(
              top: Dimensions.height5,
              left: Dimensions.height25,
              right: Dimensions.height25,
              bottom: Dimensions.height20),
          actions: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  ctrl.pendingWork(complaintid);

                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  height: Dimensions.height50,
                  padding: EdgeInsets.all(Dimensions.height2),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 39, 183, 240),
                      borderRadius: BorderRadius.circular(Dimensions.height12)),
                  child: Center(
                      child: (ctrl.loading.value == true)
                          ? const CircularProgressIndicator()
                          : Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.height18),
                            )),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height5,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Close',
                    style: GoogleFonts.poppins(color: Colors.red),
                  )),
            )
          ],
          contentPadding: EdgeInsets.only(
              right: Dimensions.height20, left: Dimensions.height20),
          title: Center(
              child: Text('Work is Pending',
                  style: GoogleFonts.poppins(
                      fontSize: Dimensions.height30,
                      fontWeight: FontWeight.w500))),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.height25))),
          content: Container(
            width: MediaQuery.of(ctx).size.width,
            height: Dimensions.height190,
            padding: EdgeInsets.all(Dimensions.height11),
            color: Colors.white,
            child: ListView(children: [
              SizedBox(
                height: Dimensions.height30,
              ),
              TextFormField(
                controller: ctrl.pendingDescription,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: inputBoxes()
                    .maininputDecoration
                    .copyWith(label: const Text('Description')),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
            ]),
          ),
        );
      });
}
