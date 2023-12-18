import 'package:flutter/material.dart';

class GlassButton extends StatelessWidget {
  String imagePath;
  final String text;
  void Function()? onTap;
  double imageSize;
  GlassButton({
    super.key,
    this.imagePath = "",
    this.imageSize = 100,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [
                  -.043,
                  0.45,
                  1.06,
                ],
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(.47),
                  Colors.white.withOpacity(.6)
                ])),
        child: Row(
            mainAxisAlignment: (imagePath == "")
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imagePath.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Image.asset(
                    imagePath,
                    color: Colors.grey[800],
                    height: imageSize,
                    width: imageSize,
                  ),
                )
              ],
              SizedBox(
                width: 25,
              ),
              Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 35,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.normal,
                    fontFamily: "PlexSans",
                  ))
            ]),
      ),
    );
  }
}
