// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getxdemo/chat_apk/services/auth/auth_gate.dart';
import 'package:getxdemo/chat_apk/services/auth/login_or_register.dart';
import 'package:getxdemo/chat_apk/screesns/sign_in.dart';
import 'package:getxdemo/chat_apk/theme/light.dart';
import 'package:getxdemo/chat_apk/theme/theme_provider.dart';
import 'package:getxdemo/firebase_options.dart';
import 'package:getxdemo/fyerchat/flyer_chat.dart';
import 'package:getxdemo/getx_apna_tution/chapter1/unnamed_routing.dart';
import 'package:getxdemo/getx_apna_tution/chapter2_namedRouting/first_page.dart';
import 'package:getxdemo/getx_apna_tution/chapter2_namedRouting/second_page.dart';
import 'package:getxdemo/getx_apna_tution/chapter2_namedRouting/third_page.dart';
import 'package:getxdemo/getx_apna_tution/chapter2_namedRouting/unknown_page.dart';
import 'package:getxdemo/getx_apna_tution/chapter3_statemanagemt/movie_page.dart';
import 'package:getxdemo/getx_apna_tution/chapter3_statemanagemt/reactive_m.dart';
import 'package:getxdemo/getx_apna_tution/chapter4_controller/con_home_view.dart';
import 'package:getxdemo/loginform/login_page.dart';
import 'package:getxdemo/pages/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   // initialRoute: "first",
    //   defaultTransition: Transition.leftToRight,
    //   getPages: [
    //     GetPage(name: "/first", page: () => FirstPage()),
    //     GetPage(name: "/second", page: () => SecondPage()),
    //     GetPage(name: "/third", page: () => ThirdPage()),
    //   ],
    //   unknownRoute: GetPage(name: "/unknown", page: () => UnknownPage()),
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //       // useMaterial3: true,
    //       ),
    //   home: ControllerHomeView(),
    // );

    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: FlyerChatPage(),
    );
  }
}
