import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'AuthController.dart';

class ComplaintController extends GetxController {
  //instace of authcontroller
  final ctrl = Get.put(AuthController());

  //Pending work description textbox
  TextEditingController pendingDescription = TextEditingController();

  //firestore instance
  FirebaseFirestore db = FirebaseFirestore.instance;
  //auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //loading
  var loading = false.obs;

  //pending work
  pendingWork(var complaintid) async {
    try {
      if (pendingDescription == ' ' || pendingDescription == '' || pendingDescription==null) {
        Get.snackbar('Warning', 'Description should be added before submit');
        print('working in pending');
        return;
      }
      loading.value = true;
      //update complaint status
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"status": 'Pending'});
      //update work table, in pending complaint field
      await db
          .collection('worker')
          .doc(ctrl.docs)
          .update({"pendingcount": FieldValue.increment(1)});
      //update pendingmsg field in complaint table
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"pendingmsg": pendingDescription.text});
      ctrl.profiledetails();
      loading.value = false;
      Get.snackbar('Done', 'Status updated sucessfully');
      pendingDescription.clear();
    } catch (e) {
      Get.snackbar('Error ⚠️', '$e');
      loading.value = false;
    }
  }

  //done
  doneWork(var complaintid,String s) async {
    try {
      
      loading.value = true;
      //update complaint status
      await db
          .collection('complaint')
          .doc(complaintid)
          .update({"status": 'Done'});
      //update work table, in pending complaint field
      if(s=='Pending'){
            await db
          .collection('worker')
          .doc(ctrl.docs)
          .update({"pendingcount": FieldValue.increment(-1)});
      }
      //update work table, in Done complaint field
      await db
          .collection('worker')
          .doc(ctrl.docs)
          .update({"donecount": FieldValue.increment(1)});
     
      ctrl.profiledetails();
      loading.value = false;
      Get.snackbar('Done', 'Status updated sucessfully');
    } catch (e) {
      Get.snackbar('Error ⚠️', '$e');
      loading.value = false;
    }
  }
}
