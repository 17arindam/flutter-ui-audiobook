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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List? popularBooks;
  ScrollController? _scrollController;
  TabController? _tabController;
  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString('lib/json/popularBooks.json')
        .then((value) {
      setState(() {
        popularBooks = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
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
                          itemCount: popularBooks?.length ?? 0,
                          controller: PageController(viewportFraction: 0.8),
                          itemBuilder: (ctx, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image:
                                      AssetImage(popularBooks?[index]["img"]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ]),
              ),
              Expanded(
                  child: NestedScrollView(
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Content'),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Content'),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Content'),
                      ),
                    ),
                  ],
                ),
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: EdgeInsets.all(0),
                          child: TabBar(
                            tabs: [
                              Container(
                                width: 120,
                                height: 50,
                                child: Text(
                                  'New',
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.menu1Color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                child: Text(
                                  'New',
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.menu2Color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                child: Text(
                                  'New',
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.menu3Color,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                              ),
                            ],
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _tabController,
                            labelPadding: EdgeInsets.all(0),
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: Offset(0, 0))
                                ]),
                          ),
                        ),
                      ),
                      pinned: true,
                    )
                  ];
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
