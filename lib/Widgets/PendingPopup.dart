


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qstart_worker/controller/ComplaintController.dart';

import '../utilities/Dimensions.dart';
import '../utilities/inputbox.dart';


//popup

final ctrl = Get.put(ComplaintController());
Future pendingPopup(BuildContext ctx,var complaintid) async
  {
    return showDialog(
      context: ctx,
          builder: (ctx1) {
      return 
          AlertDialog(
             
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.height25),bottomLeft: Radius.circular(Dimensions.height25))),
            content: Container(
               width: MediaQuery.of(ctx).size.width,
            height: Dimensions.height350,
               padding: EdgeInsets.all(Dimensions.height11),
            color: Colors.white,
              child: ListView(
                children: [
                  Center(child: Text('Work is Pending',style: GoogleFonts.poppins(fontSize: Dimensions.height30))),
                  SizedBox(height: Dimensions.height30,),
                TextFormField(
                          controller: ctrl.pendingDescription,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: inputBoxes()
                              .maininputDecoration
                              .copyWith(label: const Text('Description')),
                        ),
                SizedBox(height: Dimensions.height20,),
                 Obx(
                  () => GestureDetector(
                    onTap: (){
                 
                      ctrl.pendingWork(complaintid);
                    
                       Navigator.of(ctx).pop();
                       Navigator.of(ctx).pop();
                    },
                     child: 
                        Container(
                          height: Dimensions.height50,
                            padding:  EdgeInsets.all(Dimensions.height2),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 39, 183, 240),
                                borderRadius: BorderRadius.circular(Dimensions.height12)),
                            child:  Center(
                                child:(ctrl.loading.value==true)?CircularProgressIndicator():
                                 Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.height15),
                            )),
                          ),
                     
                   ),
                 ),
                    SizedBox(height: Dimensions.height20,),
                    TextButton(onPressed: (){
                      Navigator.of(ctx).pop();
                    }, child: const Text('Close'))
                
              ]),
            ),
          );
          }
          );
  }