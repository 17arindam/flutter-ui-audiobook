import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audiobook_app_ui/assets/app_colors.dart' as AppColors;

class DetailAudioScreen extends StatefulWidget {
  const DetailAudioScreen({super.key});

  @override
  State<DetailAudioScreen> createState() => DetailAudioScreenState();
}

class DetailAudioScreenState extends State<DetailAudioScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: AppColors.audioBlueBackground,
              ))
        ],
      ),
    );
  }
}
