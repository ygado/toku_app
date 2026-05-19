import 'package:flutter/material.dart';
import 'package:task_1/modules/splash/splash_views.dart';

import '../../models/article_model.dart';
import '../../shared/component/components.dart';

class NumbersViews extends StatelessWidget {
  const NumbersViews({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ArticleModel> articales = const [
      ArticleModel(
        images: 'assets/images/numbers/number_one.png',
        enName: 'One',
        jbName: 'Ichi',
        sound: 'sounds/numbers/number_one_sound.mp3',
      ),
      ArticleModel(
        enName: 'Two',
        jbName: 'Ni',
        sound: 'sounds/numbers/number_two_sound.mp3',
        images: 'assets/images/numbers/number_two.png',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_three.png',
        enName: 'Three',
        jbName: 'San',
        sound: 'sounds/numbers/number_three_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_four.png',
        enName: 'Four',
        jbName: 'Shi',
        sound: 'sounds/numbers/number_four_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_five.png',
        enName: 'Five',
        jbName: 'Go',
        sound: 'sounds/numbers/number_five_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_six.png',
        enName: 'Six',
        jbName: 'Roku',
        sound: 'sounds/numbers/number_six_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_seven.png',
        enName: 'Seven',
        jbName: 'Shichi',
        sound: 'sounds/numbers/number_seven_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_eight.png',
        enName: 'Eight',
        jbName: 'Hachi',
        sound: 'sounds/numbers/number_eight_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_nine.png',
        enName: 'Nine',
        jbName: 'Kyu',
        sound: 'sounds/numbers/number_nine_sound.mp3',
      ),
      ArticleModel(
        images: 'assets/images/numbers/number_ten.png',
        enName: 'Ten',
        jbName: 'Juu',
        sound: 'sounds/numbers/number_ten_sound.mp3',
      ),
    ];
    return Scaffold(
      backgroundColor: Color(0xffFF9F3B),
      appBar: defaultAppBar(
        title: 'Numbers',
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
