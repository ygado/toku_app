import 'package:flutter/material.dart';
import 'package:task_1/modules/colors/colors_views.dart';
import 'package:task_1/modules/phrases/phrases_views.dart';

import '../../shared/component/components.dart';
import '../family_members/family_members.dart';
import '../numbers/numbers_views.dart';

class SplashViews extends StatelessWidget {
  const SplashViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFDE4),
      appBar: defaultAppBar(title: 'TokuApp', iconsLeadin: Icons.arrow_back),
      body: SingleChildScrollView(
        child: Column(
          children: [
            defaultContainer(color: Color(0xffFF9F3B), text: 'Numbers', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return NumbersViews();
              }),);
            }),
            defaultContainer(color: Color(0xff5C8A3D), text: 'FamilyMembers', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return FamilyMembers();
              }),);

            }),
            defaultContainer(color: Color(0xff844BAD), text: 'Colors', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ColorsViews();
              }),);
            }),
            defaultContainer(color: Color(0xff50AFD5), text: 'Phrases', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return PhrasesViews();
              }),);


            }),
          ],
        ),
      ),
    );
  }
}
