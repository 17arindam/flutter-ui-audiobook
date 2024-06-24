import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audiobook_app_ui/assets/app_colors.dart' as AppColors;
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? popularBooks;
  readData() {
    DefaultAssetBundle.of(context)
        .loadString('lib/json/popularBooks')
        .then((value) {
      setState(() {
        popularBooks = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage('lib/assets/images/menu.png'),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.notifications,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Popular Books',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                    left: -20,
                    right: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: PageView.builder(
                          itemCount: popularBooks?.length??0,
                          controller: PageController(viewportFraction: 0.8),
                          itemBuilder: (ctx, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image:
                                      AssetImage('lib/assets/images/pic-8.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
