import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/AuthController.dart';
import '../../utilities/Dimensions.dart';
import '../../utilities/inputbox.dart';
import 'QuestionScreen.dart';


class LoginScreen extends StatelessWidget {
    LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {

  

  final ctr = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10),
        children: [
          SizedBox(
            height: Dimensions.height10, 
          ),
          //this center and column holds text for welcome
          Center(
            child: Column(
              children: [
                 Text('Welcome,',
                    style: GoogleFonts.amaranth(
                        letterSpacing: Dimensions.height2,
                        fontSize: Dimensions.height40,
                        fontWeight: FontWeight.bold,
                      )),
                Text(
                  'Glad to see you!',
                  style: GoogleFonts.firaSans(
                    fontSize: Dimensions.height28,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ), //+#
          //this container holds gif
          Container(
            height: Dimensions.height230, // +#
            width: MediaQuery.of(context).size.width, // +#
            child: Image.asset(
              
              'assets/images/LottieSignin.gif',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: Dimensions.height40,
          ), //+#
          //column for textfields
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(
              children: [
                //email id
                TextFormField(
                  controller: ctr.loginemail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputBoxes().maininputDecoration.copyWith(
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      label: const Text('Email Id')),
                ),
                SizedBox(
                  height: Dimensions.height15,
                ), //+#
                //password
               
                
                  Obx(
                   () =>TextFormField(
                    controller: ctr.loginpass,
                         // _obscureText hold a bool value which tell hide or show password
                        obscureText: ctr.obscurePassSignin.value,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(Dimensions.height12)),
                            label: const Text('Password'),
                            //hide and show button on password field
                            suffixIcon: IconButton(
                              icon: Icon( ctr.obscurePassSignin.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                               
                                // obs() {
                                   ctr.obscurePassSignin.value =  !ctr.obscurePassSignin.value;
                    
                                // }
                              },
                            ),),),
                  ),
                
                
                //forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          popUpBox(context);
                        }, child: const Text('forget password ?')),
                  ],
                ),
                //sign In button
                GestureDetector(
                  onTap: (){
                    ctr.signin();
                  },
                  child: Obx(
                    ()=> Container(
                      padding:  EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 183, 240),
                          borderRadius: BorderRadius.circular(Dimensions.height12)),
                      child:  Center(
                          child: (ctr.loading.value == true)?
                          const CircularProgressIndicator(color: Colors.white,):
                           Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimensions.height20),
                      )),
                    ),
                  ),
                ),
                //sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have a account ? '),
                    TextButton(
                        onPressed: () {
                          Get.to( QuestionScreen());
                        },
                        child: const Text(
                          'Sign Up',
                        )),
                  ],
                ),
  
              ],
            ),
          ),
        ],
      )),
    );
  }

  //popup
   Future popUpBox(BuildContext ctx) async
  {
    return showDialog(
      context: ctx,
          builder: (ctx1) {
      return 
          AlertDialog(
            actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                         GestureDetector(
                      onTap: (){
                        ctr.resetpassword();
                      },
                       child: Padding(
                         padding: const EdgeInsets.only(right: 10,left: 10),
                         child: Container(
                            height: Dimensions.height50,
                              padding:  EdgeInsets.all(Dimensions.height5),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 39, 183, 240),
                                  borderRadius: BorderRadius.circular(Dimensions.height12)),
                              child:  Center(
                                  child: Text(
                                'Send Reset Link',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimensions.height15),
                              )),
                            ),
                       ),
                     ),
              
                        TextButton(onPressed: (){
                          Navigator.of(ctx).pop();
                        }, child: const Text('Close')),
                        SizedBox(height: Dimensions.height20,),
                      ],
                    ),
                  ),
                )
            ],
            
             title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text('Forget Password ?',style: GoogleFonts.poppins(fontSize: Dimensions.height30,fontWeight: FontWeight.w500)),
               ],
             ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.height25),bottomLeft: Radius.circular(Dimensions.height25))),
            content: Container(
               width: MediaQuery.of(ctx).size.width,
            height: Dimensions.height90,
               padding: EdgeInsets.all(Dimensions.height11),
            color: Colors.white,
              child: ListView(
                children: [
                  
                  SizedBox(height: Dimensions.height10,),
                TextFormField(
                  controller: ctr.resetEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputBoxes().maininputDecoration.copyWith(
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          label: const Text('Email Id')),
                    ),
                SizedBox(height: Dimensions.height20,),
                
                
              ]),
            ),
          );
          }
    );
  }
}
