import 'package:flutter/material.dart';
import 'package:task_1/modules/splash/splash_views.dart';

import '../../models/article_model.dart';
import '../../shared/component/components.dart';

class ColorsViews extends StatelessWidget {
  const ColorsViews({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ArticleModel> articales = const [
      ArticleModel(
        images: 'assets/images/colors/color_black.png',
        enName: 'Black',
        jbName: 'Burakku',
        sound: 'sounds/colors/black.wav',
      ),
      ArticleModel(
        images: 'assets/images/colors/color_brown.png',
        enName: 'Brown',
        jbName: 'Chairo',
        sound: 'sounds/colors/brown.wav',
      ),
      ArticleModel(
        images: 'assets/images/colors/color_dusty_yellow.png',
        enName: 'Dusty yellow',
        jbName: 'Hokori ppoi kiiro',
        sound: 'sounds/colors/dusty yellow.wav',
      ),
      ArticleModel(
        images: 'assets/images/colors/color_gray.png',
        enName: 'Gray',
        jbName: 'Gurē',
        sound: 'sounds/colors/gray.wav',
      ),
      ArticleModel(
        images: 'assets/images/colors/color_green.png',
        enName: 'Green',
        jbName: 'Midori',
        sound: 'sounds/colors/green.wav',
      ),

      ArticleModel(
        images: 'assets/images/colors/color_red.png',
        enName: 'Red',
        jbName: 'Aka',
        sound: 'sounds/colors/red.wav',
      ),
      ArticleModel(
        images: 'assets/images/colors/color_white.png',
        enName: 'White',
        jbName: 'Shiroi',
        sound: 'sounds/colors/white.wav',
      ),

      ArticleModel(
        images: 'assets/images/colors/yellow.png',
        enName: 'Yellow',
        jbName: 'Kiiro',
        sound: 'sounds/colors/yellow.wav',
      ),
    ];
    return Scaffold(
      backgroundColor: Color(0xffFF9F3B),
      appBar: defaultAppBar(
        title: 'Colors',
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
