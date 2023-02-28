import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../controller/AuthController.dart';
import '../../utilities/Dimensions.dart';
import 'RegistrationScreen.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({super.key});

//   @override
//   State<QuestionScreen> createState() => _QuestionScreenState();
// }

// class _QuestionScreenState extends State<QuestionScreen> {
  final ctr1 = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                  children: [
            SizedBox(
              height: Dimensions.height30,
            ),
            //text
            Text('Who are you ?',
                style: GoogleFonts.poppins(
                    letterSpacing: Dimensions.height2,
                    fontSize: Dimensions.height35,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: Dimensions.height10,
            ), // +#
            //photo container
            Container(
              height: Dimensions.height250, // +#
              width: MediaQuery.of(context).size.width, // +#
              child: Image.asset(
                'assets/images/LottieQuestion.gif',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.height5,
                  ),
                  //row for Carpenter?
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                            value: ctr1.isCheckedCarpenter.value,
                            onChanged: (bool? value) {
                              ctr1.isCheckedCarpenter.value = value!;
                              ctr1.isCheckedElectrician.value = false;
                              ctr1.isCheckedOther.value = false;
                              ctr1.isCheckedPainter.value = false;
                              ctr1.isCheckedPlumber.value = false;
                            }),
                        Text(
                          'I\'m a Carpenter   ',
                          style: GoogleFonts.poppins(
                            fontSize: Dimensions.height20,
                          ),
                        ),
                        const Spacer(),
                        if (ctr1.isCheckedCarpenter.value == true)
                          //  Icon(
                          //   Icons.check,
                          //   color: Colors.green,
                          //   size: 30,
                          // ),
                          Lottie.network(
                            // 'assets/images/tick.json',
                              "https://assets8.lottiefiles.com/packages/lf20_AWGRRVDFNv.json",
                              animate: true,
                              repeat: false,
                              fit: BoxFit.fill,
                              height: Dimensions.height100,
                           width: Dimensions.width90,
                              )
                      ],
                    ),
                  ),
                 
                  //row for Electrician?
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                            value: ctr1.isCheckedElectrician.value,
                            onChanged: (bool? value) {
                              ctr1.isCheckedElectrician.value = value!;
                              ctr1.isCheckedCarpenter.value = false;
                              ctr1.isCheckedOther.value = false;
                              ctr1.isCheckedPainter.value = false;
                              ctr1.isCheckedPlumber.value = false;
                            }),
                        Text(
                          'I\'m a Electrician',
                          style: GoogleFonts.poppins(
                            fontSize: Dimensions.height20,
                          ),
                        ),
                        const Spacer(),
                        if (ctr1.isCheckedElectrician.value == true)
                          //  Icon(
                          //   Icons.check,
                          //   color: Colors.green,
                          //   size: 30,
                          // ),
                          Lottie.network(
                              "https://assets8.lottiefiles.com/packages/lf20_AWGRRVDFNv.json",
                              animate: true,
                              repeat: false,
                              fit: BoxFit.cover,
                              height: Dimensions.height100,
                              width: Dimensions.width90
                              )
                      ],
                    ),
                  ),
                  //row for Painter?
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                            value: ctr1.isCheckedPainter.value,
                            onChanged: (bool? value) {
                              ctr1.isCheckedPainter.value = value!;
                              ctr1.isCheckedCarpenter.value = false;
                              ctr1.isCheckedElectrician.value = false;
                              ctr1.isCheckedOther.value = false;
                              ctr1.isCheckedPlumber.value = false;
                            }),
                        Text(
                          'I\'m a Painter     ',
                          style: GoogleFonts.poppins(
                            fontSize: Dimensions.height20,
                          ),
                        ),
                        const Spacer(),
                        if (ctr1.isCheckedPainter.value == true)
                          //  Icon(
                          //   Icons.check,
                          //   color: Colors.green,
                          //   size: 30,
                          // ),
                          Lottie.network(
                              "https://assets8.lottiefiles.com/packages/lf20_AWGRRVDFNv.json",
                              animate: true,
                              repeat: false,
                              fit: BoxFit.cover,
                              height: Dimensions.height100,
                              width: Dimensions.width90),
                      ],
                    ),
                  ),
          
                  //row for Plumber?
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                            value: ctr1.isCheckedPlumber.value,
                            onChanged: (bool? value) {
                              ctr1.isCheckedPlumber.value = value!;
                              ctr1.isCheckedCarpenter.value = false;
                              ctr1.isCheckedElectrician.value = false;
                              ctr1.isCheckedOther.value = false;
                              ctr1.isCheckedPainter.value = false;
                            }),
                        Text(
                          'I\'m a Plumber     ',
                          style: GoogleFonts.poppins(
                            fontSize: Dimensions.height20,
                          ),
                        ),
                        const Spacer(),
                        if (ctr1.isCheckedPlumber.value == true)
                          //  Icon(
                          //   Icons.check,
                          //   color: Colors.green,
                          //   size: 30,
                          // ),
                          Lottie.network(
                              "https://assets8.lottiefiles.com/packages/lf20_AWGRRVDFNv.json",
                              animate: true,
                              repeat: false,
                              fit: BoxFit.cover,
                              height: Dimensions.height100,
                              width: Dimensions.width90),
                      ],
                    ),
                  ),
                  //row for other?
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                            value: ctr1.isCheckedOther.value,
                            onChanged: (bool? value) {
                              ctr1.isCheckedOther.value = value!;
                              ctr1.isCheckedCarpenter.value = false;
                              ctr1.isCheckedElectrician.value = false;
                              ctr1.isCheckedPainter.value = false;
                              ctr1.isCheckedPlumber.value = false;
                            }),
                        Text(
                          'None of above(Others)',
                          style: GoogleFonts.poppins(
                            fontSize: Dimensions.height20,
                          ),
                        ),
                        const Spacer(),
                        if (ctr1.isCheckedOther.value == true)
                          //  Icon(
                          //   Icons.check,
                          //   color: Colors.green,
                          //   size: 30,
                          // ),
                          Lottie.network(
                              "https://assets8.lottiefiles.com/packages/lf20_AWGRRVDFNv.json",
                              animate: true,
                              repeat: false,
                              fit: BoxFit.cover,
                              height: Dimensions.height100,
                              width: Dimensions.width90),
                      ],
                    ),
                  ),
                  //next button
                  GestureDetector(
                    onTap: () {
                      ontaponNext();
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 183, 240),
                          borderRadius: BorderRadius.circular(Dimensions.height12)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.height20),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
                  ],
                ),
          )),
    );
  }

  void ontaponNext() {
    if (ctr1.isCheckedCarpenter.value) {
      ctr1.type = "Carpenter";
    } else if (ctr1.isCheckedElectrician.value) {
      ctr1.type = "Electrician";
    } else if (ctr1.isCheckedOther.value) {
      ctr1.type = "Other";
    }
    else if (ctr1.isCheckedPainter.value) {
      ctr1.type = "Painter";
    }
    else if (ctr1.isCheckedPlumber.value) {
      ctr1.type = "Plumber";
    }

    if (ctr1.type != null) {
      Get.to(RegistrationScreen());
    } else {
      Get.snackbar("Alert", "Select a option to continue",
          backgroundColor: Color.fromARGB(255, 169, 201, 228));
    }
  }
}
