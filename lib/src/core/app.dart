import 'package:api_nasa/src/core/app_constants.dart';
import 'package:api_nasa/src/pages/config/config_page.dart';
import 'package:api_nasa/src/pages/details/details_page.dart';
import 'package:api_nasa/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Nasa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppConstants.home: (_) => const HomePage(),
        AppConstants.detailsPage: (_) => const DetailsPage(),
        AppConstants.configPage: (_) => const ConfigPage(),
      },
    );
  }
}
