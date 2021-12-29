import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/providers/business_provider.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/revenge/revenge.dart';
import 'package:provider/provider.dart';

void main() {
  DateTime revengeDate = DateTime.utc(2022, 2, 28);
  
  if (DateTime.now().isBefore(revengeDate)) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ],
        child: MyApp(),
      ),
    );
  } else {
    runApp(RevengeApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Everything in SouthKey',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class RevengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Don\'t work there',
      home: RevengeScreen(),
    );
  }
}
