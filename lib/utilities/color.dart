import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColor {
  //maingradient
  Gradient mainGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.white12,
        Colors.white24,
        Colors.blue.shade100,
        Colors.blue.shade200,
        Colors.blue.shade400,
      ]);

  //maingradient
  Gradient secondGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Colors.blue.shade700,
        Colors.blue.shade800,
      ]);

  //container color
  static final doneColour = Colors.lightGreen.shade400;
  static final doneVerifiedColour = Colors.green.shade400;
  static final pendingColour = Colors.orange.shade700;
  static final declainedColour = Colors.redAccent;
  static final processingColour = Colors.lightBlueAccent;
  static final requestedColour = Colors.purple.shade700;

  //text color
  static final donetextColour = Colors.white;
  static final doneVerifiedtextColour = Colors.white;
  static final pendingtextColour = Colors.white54;
  static final declainedtextColour = Colors.white54;
  static final processingtextColour = Colors.black87;
  static final requestedtextColour = Colors.white54;
}
