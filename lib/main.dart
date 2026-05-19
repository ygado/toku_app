import 'package:flutter/material.dart';
import 'package:task_1/modules/home_views/home_views.dart';

void main(){
  runApp(TokuApp());
}

class TokuApp extends StatelessWidget {
  const TokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeViews(),
    );
  }
}
