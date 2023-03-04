import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qstart_worker/Model/authWorkerModel.dart';
import 'package:qstart_worker/Screens/worker/WorkerNavScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/MainScreens/LoginScreen.dart';
import '../Screens/MainScreens/VerificationScreen.dart';

class AuthController extends GetxController{

   //create instance of firebase:
    //auth
   FirebaseAuth auth = FirebaseAuth.instance;
    //storage
   FirebaseFirestore db = FirebaseFirestore.instance;

  //image url
   String imgUrl='';
   //profile photo obs
   var profimg = ''.obs;
   //currentuser docs id of worker table
   var docs;
  //profiledata is a map varable which holds the data of Worker from Worker table by check their email 
  late Map<String, dynamic> profiledata;
   
   //signin obscurepassword
  var obscurePassSignin = true.obs;
  var obscurePassOneSignup = true.obs;


  //question screen
  var isCheckedCarpenter = false.obs;
  var isCheckedPainter = false.obs;
  var isCheckedPlumber = false.obs;
  var isCheckedElectrician = false.obs;
  var isCheckedOther = false.obs;

  //type of Worker(Carpenter,Painter,Plumber,Electrician,Other)
  String? type;

  //loading var for loading indication
   var loading = false.obs;

    // create controller:
  //sign up
  TextEditingController username= TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController registeremail = TextEditingController();
  TextEditingController registerpass = TextEditingController();

  //sign in
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpass = TextEditingController();

  //forget password
   TextEditingController resetEmail = TextEditingController();
   

   //create accounts with email and password
  signUp()async{
    try{
    loading.value = true;
    await auth.createUserWithEmailAndPassword(email: registeremail.text, password: registerpass.text);
    await addUser();
    await verifyemail();
    await profiledetails();
     await auth.signInWithEmailAndPassword(email: registeremail.text, password: registerpass.text);
     SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", "${auth.currentUser!.uid}");
      String? id=prefs.getString("uid");
  
    Get.offAll(VerificationScreen());
    loading.value=false;
    registeremail.clear();
    registerpass.clear();
    }
    catch(e){
      Get.snackbar("Error", "$e");
      loading.value = false;
    }
  }

  //add user to database
  addUser()async{
    authWorkerModel user = authWorkerModel(
      username: username.text,
      phoneNo: phoneNo.text,
      email: auth.currentUser?.email,
      id: auth.currentUser?.uid,
      type: type,
      profileimg: '',
      totalcomplaintcount: 0,
      donecount:0,
      pendingcount: 0
    );
    await db.collection("worker").add(user.toMap());
  }

   //signout
  signout()async{
    await auth.signOut();
    print('Currentuser');
    print(auth.currentUser?.email);
    loginemail.clear();
    loginpass.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginScreen());
  }

   //signin
  signin()async{
    try{
      loading.value= true;
      await auth.signInWithEmailAndPassword(email: loginemail.text, password: loginpass.text);


      //check whether user is present in user table or not
      int checkuser=0;
      var collection = db.collection('worker');
      var querySnapshot = await collection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
      //each docs is accessed to data var on each iteration
       Map<String, dynamic> data = queryDocumentSnapshot.data();
      
            //checking whether email id in docs on this iteration is equal to current user
            if(data['email']==auth.currentUser!.email){
                 checkuser=1;
              }
          }
        if(checkuser==0)
        {
          auth.signOut();
          Get.snackbar('Error', 'You are not a Worker');
          loading.value=false;
          loginemail.clear();
          loginpass.clear();
          return;
        }
      //end of user exit or not check


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("uid", auth.currentUser!.uid);
      await profiledetails();
      // Get.offAll(UserNavScreen());
      if(!auth.currentUser!.emailVerified)
      {
          Get.offAll(VerificationScreen());
      }
      else
      {
          Get.offAll(WorkerNavScreen());
      }
      loginemail.clear();
      loginpass.clear();
      loading.value=false;
    }
    catch(e){
      Get.snackbar("Error", "$e");
      loading.value=false;
    }
  }


//verify email
  verifyemail()async{
    await auth.currentUser?.sendEmailVerification();
    Get.snackbar("Verification", "Verification e-mail has send");
  }

  //reset password
  resetpassword()async{
    try{
      await auth.sendPasswordResetEmail(email: resetEmail.text);
      Get.back();
      Get.snackbar("E-mail", "E-mail to reset password have been successfully send");
    }
    catch(e){
      Get.snackbar("Error", "$e");
    }
  }



  //get data
  profiledetails() async{
  
  var collection = db.collection('worker');
  var querySnapshot = await collection.get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    //each docs is accessed to data var on each iteration
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      
      //checking whether email id in docs on this iteration is equal to current user
      if(data['email']==auth.currentUser!.email){
          profiledata = data;
          docs=queryDocumentSnapshot.id;
      }
    }
  }



//profile img
addProfileImage() async{

    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery,
    imageQuality: 99,
    );

    if(file==null || file=='' || file==' '){
      Get.snackbar('Unable to update', 'Choose a file to change our profile photo');
      return;
    }
    Get.snackbar('Uploading ...','Please wait.');
    //creating a unique file name to image using datetime.now() function
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child('WorkerProfileImages');
    if(profiledata['profileimg']!=''){
      // Reference refdelete = referenceDir.child(profiledata['profileimg']);
      await FirebaseStorage.instance.refFromURL(profiledata['profileimg']).delete();
      // refdelete.delete();
      print('deleted');
    }
    
    Reference referenceImage = referenceDir.child(uniqueFileName);
    
    
    try{
      //upload image
      await referenceImage.putFile(File(file.path));
      //Sucess: Get image download url 
      imgUrl = await referenceImage.getDownloadURL();

      await db.collection("worker")
      .doc(docs)
      .update({"profileimg": imgUrl});
      
      
      print('$imgUrl');
      Get.snackbar('Success 👍', 'Profile photo uploaded successfully\n It will take some to display changes');
      profiledetails();
    }
    catch(e){
        Get.snackbar('Error', '$e');
        loading.value=false;
        return;
    }
  }

}