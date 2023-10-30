// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
//
// import '../../App Services/api_services_provider.dart';
// import '../../constants/color_app.dart';
//
// class ObjectiveScreen extends StatefulWidget {
//   const ObjectiveScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ObjectiveScreen> createState() => _ObjectiveScreenState();
// }
//
// class _ObjectiveScreenState extends State<ObjectiveScreen> {
//   QuillController _controller = QuillController.basic();
//   @override
//   Widget build(BuildContext context) {
//     var brightness = MediaQuery.of(context).platformBrightness;
//     bool isDarkMode = brightness == Brightness.dark;
//     DataServices dataServices = DataServices();
//     return Scaffold(
//       backgroundColor:
//       isDarkMode == true ? ColorApp.colorblack : ColorApp.colorbackground,
//       appBar: AppBar(
//
//       ),
//       body: Column(
//         children: [
//           QuillToolbar.basic(controller: _controller),
//           Expanded(
//             child: Container(
//               child: QuillEditor.basic(
//                 controller: _controller,
//                 readOnly: false, // true for view only mode
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
