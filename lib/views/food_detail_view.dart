import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_animation/utils/food_details.dart';

List<Map<String, dynamic>> categories = [
  {"name": "Banana", "price": "72.5", "color": const Color(0xffebd04c)},
  {"name": "Turnip", "price": "50.5", "color": const Color(0xfffea9b0)},
  {"name": "Renegade", "price": "40.0", "color": const Color(0xff717ba8)},
];
List<Map<String, dynamic>> searches = [
  {"name": "ORANGE", "color": const Color(0xfffebf57)},
  {
    "name": "GUAVA",
    "color": const Color(0xfffd576c),
  },
  {
    "name": "PEACH",
    "color": const Color(0xfffeb2a4),
  },
];
List<Map<String, dynamic>> tags = [
  {"name": "Salad", "isSelected": true},
  {"name": "Vegan", "isSelected": false},
  {"name": "Plum", "isSelected": false},
  {"name": "Green", "isSelected": false},
  {"name": "Meat", "isSelected": false},
  {"name": "Spicy", "isSelected": true},
  {"name": "Cook", "isSelected": false},
  {"name": "Hot", "isSelected": false},
  {"name": "Red", "isSelected": false}
];

class FoodDetailsView extends StatefulWidget {
  final String assetName;
  const FoodDetailsView({required this.assetName, super.key});

  @override
  State<FoodDetailsView> createState() => _FoodDetailsViewState();
}

class _FoodDetailsViewState extends State<FoodDetailsView> {
  List<Widget> _animatedWidgets = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (Widget i in foodDetailsWidget(context)) {
        setState(() {
          _animatedWidgets.add(i);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xff2f343e),
      body: Stack(
        children: [
          // Food
          Positioned(
            top: -(size.height * 0.2),
            child: Hero(
                tag: widget.assetName,
                child: SizedBox(
                  width: size.width,
                  child: Image.asset(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: size.width,
                      widget.assetName),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _animatedWidgets
                  .map((e) => e
                      .animate()
                      .slideY(
                          begin: 5,
                          duration: Duration(
                            milliseconds:
                                500 * (_animatedWidgets.indexOf(e) + 1),
                          ),
                          curve: Curves.easeOut)
                      .fadeIn(
                        begin: 0.1,
                        delay: Duration(
                            milliseconds:
                                300 * (_animatedWidgets.indexOf(e) + 1)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
