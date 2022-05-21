import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BianatTask());
}

class BianatTask extends StatelessWidget {
  const BianatTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GetMaterialApp(
      title: 'Bianat Task',
      initialRoute: AppRoutes.goToAuthRoute(),
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
