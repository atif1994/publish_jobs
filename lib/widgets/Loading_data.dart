import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_color.dart';

class ProgressLoading extends StatelessWidget {
  const ProgressLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Container(
      width: s.width * 0.9,
      height: s.height * 0.08,
      color: Colors.black12,
      child: SpinKitDoubleBounce(
        duration: Duration(seconds: 4),
        color: AppColors.colorprimary,
      ),
    );
  }
}
