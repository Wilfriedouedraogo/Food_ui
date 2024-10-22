import 'package:flutter/cupertino.dart';
import 'package:food_animation/widgets/categories.dart';
import 'package:food_animation/widgets/search.dart';
import 'package:food_animation/widgets/tags.dart';

List<Widget> foodDetailsWidget(BuildContext context) => [
      SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.25,
      ),
      // category
      Categories(),
      RecentSearch(),
      Tags()
    ];
