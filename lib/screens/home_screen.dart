import 'dart:convert';

import 'package:audiobook_app_ui/widgets/app_tabs.dart';
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
  List? books;
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
    await DefaultAssetBundle.of(context)
        .loadString('lib/json/books.json')
        .then((value) {
      setState(() {
        books = json.decode(value);
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
                    ListView.builder(
                        itemCount: books == null ? 0 : books?.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.tabVarViewColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2)),
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  books?[index]['img']))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColors.starColor,
                                              size: 24,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              books?[index]['rating'],
                                              style: TextStyle(
                                                  color: AppColors.menu2Color),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          books?[index]['title'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          books?[index]['text'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Avenir',
                                              color: AppColors.subTitleText),
                                        ),
                                        Container(
                                          width: 60,
                                          alignment: Alignment.center,
                                          height: 18,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColors.loveColor),
                                              child: Text(
                                          'Love',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Avenir',
                                              color: Colors.white
                                              ),
                                              
                                        ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
                      backgroundColor: AppColors.sliverBackground,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, left: 10),
                          child: TabBar(
                            tabs: [
                              AppTabs(color: AppColors.menu1Color, text: 'New'),
                              AppTabs(
                                  color: AppColors.menu2Color, text: 'Popular'),
                              AppTabs(
                                  color: AppColors.menu3Color,
                                  text: 'Trending'),
                            ],
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _tabController,
                            labelPadding: EdgeInsets.only(right: 10),
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
