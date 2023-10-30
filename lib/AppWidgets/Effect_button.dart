import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../App Services/api_services_provider.dart';
import '../api/api.dart';
import '../utils/app_color.dart';

class EffectButton extends StatefulWidget {
final IconData icon;
  final dynamic? Ontap;
final double? widthButton;
final double? heightButton;
final Color? color;


   EffectButton({Key? key,required this.Ontap,required this.icon,this.heightButton,this.widthButton,this.color}) : super(key: key);

  @override
  State<EffectButton> createState() => _EffectButtonState();
}

class _EffectButtonState extends State<EffectButton> {


  @override
  Widget build(BuildContext context) {
    ABD abd = ABD();
    DataServices dataServices = DataServices();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return  Material(
      color: Colors.white
          .withOpacity(0.0),
      child: InkWell(
          splashColor: AppColors.colorindigo.withOpacity(0.5),
        child: Container(
          height: s.height * 0.025,
          width: s.width * 0.075,
          child:
          Icon(widget.icon,
            size: 18,
            color: widget.color,
         ),
        ),
        onTap: widget.Ontap
      ),
    );
  }
}
