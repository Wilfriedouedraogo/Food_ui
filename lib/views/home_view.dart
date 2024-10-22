import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_animation/models/box_content.dart';
import 'package:food_animation/views/food_detail_view.dart';
import 'package:food_animation/widgets/food_box.dart';
import 'package:google_fonts/google_fonts.dart';

List<BoxContent> boxContent = [
  BoxContent(asset: "assets/cereal.png", color: Colors.orange),
  BoxContent(asset: "assets/spag.png", color: Colors.greenAccent),
  BoxContent(asset: "assets/steak.png", color: Colors.pinkAccent),
  BoxContent(asset: "assets/veggies.png", color: Colors.blueAccent),
  BoxContent(asset: "assets/veggies.png", color: Colors.black),
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  GlobalKey heroKey = GlobalKey();
  final Duration _animationDuration = const Duration(milliseconds: 500);
  int currIndex = 0;
  int? previousIndex;
  late AnimationController _growAnimationController;
  late AnimationController _shrinkAnimationController;
  late AnimationController _rotationAnimationController;
  late ScrollController _scrollController;
  late Animation<double> _growAnimation;
  late Animation<double> _shrinkAnimation;
  late Animation<double> _rotationAnimation;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _growAnimationController =
        AnimationController(vsync: this, duration: _animationDuration);
    _growAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_growAnimationController);

    _shrinkAnimationController =
        AnimationController(vsync: this, duration: _animationDuration);
    _shrinkAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_shrinkAnimationController);

    _rotationAnimationController =
        AnimationController(vsync: this, duration: _animationDuration);

    _rotationAnimation = CurvedAnimation(
        parent: _rotationAnimationController, curve: Curves.easeIn);

    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _growAnimationController.forward();
    });
  }

  void handleIndexChange(int newIndex) {
    if (newIndex >= 0 && newIndex < boxContent.length - 1) {
      setState(() {
        previousIndex = currIndex;
        currIndex = newIndex;
      });

      _growAnimationController.reset();
      _growAnimationController.forward();

      if (previousIndex != newIndex) {
        _shrinkAnimationController.reset();
        _shrinkAnimationController.forward();
      }

      double position =
          newIndex * (MediaQuery.of(context).size.width * 0.8 + 15);
      _scrollController.animateTo(position,
          duration: _animationDuration, curve: Curves.easeIn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    _growAnimationController.dispose();
    _shrinkAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double maxHeight = size.height * 0.7;
    double minHeight = size.height * 0.5;
    double boxWidth = size.width * 0.8;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 52, 62, 1),
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: const Color(0xff2f343e),
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 8,
          ),
        ),
        title: Text(
          "DISCOVER",
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            height: size.height * 0.1,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "F      E     A     T     .",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ".      U     R     E     D",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx < 0 &&
                    currIndex < boxContent.length - 1) {
                  handleIndexChange(currIndex + 1);
                } else if (details.velocity.pixelsPerSecond.dx > 0 &&
                    currIndex > 0) {
                  handleIndexChange(currIndex - 1);
                }
              },
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: boxContent.length,
                  itemBuilder: (context, index) {
                    final itemScrollOffset = index * boxWidth - _scrollOffset;
                    final visiblePortion =
                        1 - (itemScrollOffset / boxWidth).clamp(0.0, 1.0);
                    if (index == (boxContent.length - 1)) {
                      return const SizedBox(
                        width: 50,
                      );
                    }
                    return FoodBox(
                      onTap: () {
                        if (currIndex == index) {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => FoodDetailsView(
                                  assetName: boxContent[index].asset)));
                        } else {
                          handleIndexChange(index);
                        }
                      },
                      index: index,
                      growAnimation: _growAnimation,
                      shrinkAnimation: _shrinkAnimation,
                      minHeight: minHeight,
                      maxHeight: maxHeight,
                      boxWidth: boxWidth,
                      previousIndex: previousIndex,
                      currIndex: currIndex,
                      visiblePortion: visiblePortion,
                      progressAnimation: _rotationAnimation,
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
