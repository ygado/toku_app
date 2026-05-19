import 'package:flutter/material.dart';
import 'package:task_1/modules/splash/splash_views.dart';

import '../../models/article_model.dart';
import '../../shared/component/components.dart';

class FamilyMembers extends StatelessWidget {
  const FamilyMembers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ArticleModel> articales = const [
      ArticleModel(
        images: 'assets/images/family_members/family_father.png',
        enName: 'Father',
        jbName: 'Chichioya',
        sound: 'sounds/family_members/father.wav',
      ),

      ArticleModel(
        images: 'assets/images/family_members/family_mother.png',
        enName: 'Mother',
        jbName: 'Hahaoya',
        sound: 'sounds/family_members/mother.wav',
      ),
      ArticleModel(
        images: 'assets/images/family_members/family_son.png',
        enName: 'Son',
        jbName: 'Musuko',
        sound: 'sounds/family_members/son.wav',
      ),

      ArticleModel(
        images: 'assets/images/family_members/family_daughter.png',
        enName: 'Daughter',
        jbName: 'Musume',
        sound: 'sounds/family_members/daughter.wav',
      ),

      ArticleModel(
        images: 'assets/images/family_members/family_older_brother.png',
        enName: 'Older brother',
        jbName: 'Ani',
        sound: 'sounds/family_members/older bother.wav',
      ),
      ArticleModel(
        images: 'assets/images/family_members/family_older_sister.png',
        enName: 'Older sister',
        jbName: 'Ane',
        sound: 'sounds/family_members/older sister.wav',
      ),
      ArticleModel(
        images: 'assets/images/family_members/family_younger_brother.png',
        enName: 'Younger brother',
        jbName: 'Otouto',
        sound: 'sounds/family_members/younger brohter.wav',
      ),

      ArticleModel(
        images: 'assets/images/family_members/family_younger_sister.png',
        enName: 'Younger sister',
        jbName: 'Imouto',

        sound: 'sounds/family_members/younger sister.wav',
      ),

      ArticleModel(
        images: 'assets/images/family_members/family_grandfather.png',
        enName: 'Grandfather',
        jbName: 'Sofu',
        sound: 'sounds/family_members/grand father.wav',
      ),

      ArticleModel(
        images: 'assets/images/family_members/family_grandmother.png',
        enName: 'Grandmother',
        jbName: 'Sobo',
        sound: 'sounds/family_members/grand mother.wav',
      ),
    ];
    return Scaffold(
      backgroundColor: Color(0xff5C8A3D),
      appBar: defaultAppBar(
        title: 'FamilyMembers',
        iconsLeadin: Icons.arrow_back,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SplashViews();
              },
            ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: articales.length,
        itemBuilder: (context, index) {
          return DefaultItem(articales: articales[index]);
        },
      ),
    );
  }
}
