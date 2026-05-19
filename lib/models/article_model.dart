import 'package:audioplayers/audioplayers.dart';

class ArticleModel {
 final String enName;
 final String jbName;
 final  String? images;
 final  String sound;
 const ArticleModel({
    required this.enName,
    required this.jbName,
    this.images,
    required this.sound,
});

 void playSound() {
   final player = AudioPlayer();
   player.play(AssetSource(sound));
 }
}