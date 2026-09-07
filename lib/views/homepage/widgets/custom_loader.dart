import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget customLoader(BuildContext context) {
  return Lottie.asset(
    "assets/images/loading.json",
    width: MediaQuery.of(context).size.width,
  );
}
