  //popup
   import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/ComplaintController.dart';
import '../utilities/Dimensions.dart';


final ctrl = Get.put(ComplaintController());

Future DonepopUpBox(BuildContext ctx,var complaintid,String s) async
  {
    
    return showDialog(
      context: ctx,
          builder: (ctx1) {
      return 
          AlertDialog(
             
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.height25))),
            content: Container(
               width: MediaQuery.of(ctx).size.width,
            height: Dimensions.height190,
               padding: EdgeInsets.all(Dimensions.height11),
            color: Colors.white,
              child: ListView(
                children: [
                  Center(child: Text('Conform',style: GoogleFonts.amaranth(fontSize: Dimensions.height30,fontWeight: FontWeight.bold))),
                  SizedBox(height: Dimensions.height10,),
                  Text('Work is completed?',style: GoogleFonts.poppins(fontSize: Dimensions.height20,fontWeight: FontWeight.w500),),
                  Text('You can\'t undo this action',style: GoogleFonts.poppins(fontSize: Dimensions.height18),),
                  SizedBox(height: Dimensions.height20,),
                  Divider(thickness: Dimensions.height1,),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                        Navigator.of(ctx).pop();
                      }, child: Text('Close',style: GoogleFonts.poppins(fontSize: Dimensions.height15),)),
                      VerticalDivider(thickness: Dimensions.height1,),
                      TextButton(onPressed: (){
                              ctrl.doneWork(complaintid, s);
                       Navigator.of(ctx).pop();
                       Navigator.of(ctx).pop();
                      }, child: Text('Conform',style: GoogleFonts.poppins(fontSize:Dimensions.height15,color: Colors.lightBlue),)),
                      ],
                    ),
                  ),
                    SizedBox(height: Dimensions.height20,),
                    
                
              ]),
            ),
          );
          }
    );
  }