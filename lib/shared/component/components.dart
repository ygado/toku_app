import 'package:flutter/material.dart';
import 'package:task_1/models/article_model.dart';

AppBar defaultAppBar({
  IconData? iconsLeadin,
  IconData? iconsAcction1,
  IconData? iconsAcction2,
  required String title,
  Function()? onPressed,
}) => AppBar(
  backgroundColor: Colors.brown,
  leading: iconsLeadin != null
      ? defaultIconButton(icons: iconsLeadin, onPressed: onPressed)
      : null,
  title: defaultText(text: title, color: Colors.white, size: 20),
  actions: [
    if (iconsAcction1 != null) defaultIconButton(icons: iconsAcction1),

    if (iconsAcction2 != null) defaultIconButton(icons: iconsAcction2),
  ],
);

Widget defaultIconButton({required IconData icons, Function()? onPressed}) =>
    IconButton(
      highlightColor: Colors.white,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      icon: Icon(icons, color: Colors.black),
    );

Widget defaultText({
  required String text,
  required Color color,
  required double size,
  TextOverflow? overflow,
  int? maxLines,
}) => Text(
  maxLines: maxLines,
  overflow: overflow,
  text,
  style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
);

Widget defaultTextField({
  TextEditingController? controller,
  ValueChanged? onChanged,
  ValueChanged? onFieldSubmitted,
  required bool isPassword,
  TextInputType? keyboardType,
  FormFieldValidator? validator,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixOnPressed,
}) => TextFormField(
  controller: controller,
  onChanged: onChanged,
  onFieldSubmitted: onFieldSubmitted,
  obscureText: isPassword,
  keyboardType: keyboardType,
  validator: validator,
  decoration: InputDecoration(
    labelText: text,
    prefixIcon: Icon(prefix, color: Colors.brown),
    suffixIcon: IconButton(
      onPressed: suffixOnPressed,
      icon: Icon(suffix, color: Colors.brown),
    ),
    border: OutlineInputBorder(),
  ),
);

Widget defaultMaterialButton({
  Color? containerColor,
  required double fonSize,
  double? width,
  required String text,
  required Function() onPressed,
  required Color color,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: Container(
    width: width,
    child: MaterialButton(
      color: containerColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: defaultText(text: text, color: color, size: fonSize),
    ),
  ),
);

Widget defaultContainer({
  required Color color,
  required String text,
  required Function() onPressed,
}) => GestureDetector(
  onTap: onPressed,
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.centerLeft,
    width: double.infinity,
    height: 100,
    color: color,
    child: defaultText(text: text, color: Colors.white, size: 35),
  ),
);

class DefaultItem extends StatelessWidget {
  const DefaultItem({super.key, required this.articales});
  final ArticleModel articales;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Container(
                height: 75,
                color: Color(0xffFFFDE4),
                child: Image(image: AssetImage(articales.images!)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: articales.jbName.toUpperCase(),
                      color: Colors.white,
                      size: 20,
                    ),
                    defaultText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: articales.enName.toUpperCase(),
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: defaultIconButton(
                icons: Icons.play_arrow,
                onPressed: () {
                  articales.playSound();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PhrasesItem extends StatelessWidget {
  const PhrasesItem({super.key, required this.articales});
  final ArticleModel articales;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: articales.jbName.toUpperCase(),
                        color: Colors.white,
                        size: 20,
                      ),
                      defaultText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: articales.enName.toUpperCase(),
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: defaultIconButton(
                  icons: Icons.play_arrow,
                  onPressed: () {
                    articales.playSound();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
