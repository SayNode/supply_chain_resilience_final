import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

class SocialBox extends StatelessWidget {
  const SocialBox({
    Key? key,
    required this.screenSize,
    required this.imagePath,
  }) : super(key: key);

  final Size screenSize;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04, vertical: screenSize.width * 0.03) ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ChainColor.borderBlue1),
      ),
      child: Image.asset(imagePath, width: screenSize.width * 0.04,),
    );
  }
}