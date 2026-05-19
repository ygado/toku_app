import 'package:flutter/material.dart';
import 'package:task_1/modules/splash/splash_views.dart';

import '../../models/article_model.dart';
import '../../shared/component/components.dart';

class PhrasesViews extends StatelessWidget {
  const PhrasesViews({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ArticleModel> articales = const [
      ArticleModel(
        jbName: 'namae wa nan desu ka',
        enName: 'what is your name',
        sound: 'sounds/phrases/what_is_your_name.wav',
      ),

      ArticleModel(
        jbName: 'Doko e iku no?',
        enName: 'Where are you going?',
        sound: 'sounds/phrases/where_are_you_going.wav',
      ),

      ArticleModel(
        jbName: 'kimasu ka',
        enName: 'Are you coming?',
        sound: 'sounds/phrases/are_you_coming.wav',
      ),
      ArticleModel(
        jbName: 'hai, kimasu',
        enName: 'yes, I\'m coming',
        sound: 'sounds/phrases/yes_im_coming.wav',
      ),

      ArticleModel(
        jbName: 'kibun wa dō desu ka',
        enName: 'how are you feeling',
        sound: 'sounds/phrases/how_are_you_feeling.wav',
      ),

      ArticleModel(
        jbName: 'anime ga daisuki desu',
        enName: 'i love anime',
        sound: 'sounds/phrases/i_love_anime.wav',
      ),

      ArticleModel(
        jbName: 'Puroguramingu suki',
        enName: 'i love programming',

        sound: 'sounds/phrases/i_love_programming.wav',
      ),

      ArticleModel(
        jbName: 'Puroguramingu kantan',
        enName: 'programming is easy',
        sound: 'sounds/phrases/programming_is_easy.wav',
      ),
    ];
    return Scaffold(
      backgroundColor: Color(0xff50AFD5),
      appBar: defaultAppBar(
        title: 'Phrases',
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
          return PhrasesItem(articales: articales[index]);
        },
      ),
    );
  }
}
