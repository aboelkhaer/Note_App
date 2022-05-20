import 'package:bianat_app/controller/controllers.dart';
import 'package:bianat_app/view/auth_screen.dart';
import 'package:bianat_app/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

// class Root extends StatelessWidget {
//   const Root({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<AuthController>(
//         init: AuthController(),
//         builder: (controller) {
//           return controller.isSignedIn.value ? HomeScreen() : AuthScreen();
//         },
//       ),
//     );
//   }
// }
