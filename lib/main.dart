import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

import 'controllers/view_controller.dart';
import 'init.dart';
import 'views/main_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    final ViewController _viewController = Get.put(ViewController());
    
    final Future<String> _initialization = Init.initialize();

    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {

          Iterable l = jsonDecode(snapshot.data!);
          List<Tweet> tweets = List<Tweet>.from(l.map((model) => Tweet.fromJson(model)));

          _viewController.tweets = tweets;
          _viewController.getTypes();

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: bgColor,
              textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: bodyColor)
            ),
            home: const MainView(),
          );

        }

        return const CircularProgressIndicator.adaptive();

      }
    );
  }
}

class Tweet {

  final String date;
  final String content;
  final String location;
  final String service;
  final String social;

  Tweet({
    required this.date,
    required this.content,
    required this.location,
    required this.service,
    required this.social,
  });

  Tweet.fromJson(Map<String,dynamic> json):
    date = json['Fecha'],
    content = json['Contenido'],
    location = json['Ubicacion'],
    service = json['Servicio'],
    social = json['Red_Social']
  ;

}
