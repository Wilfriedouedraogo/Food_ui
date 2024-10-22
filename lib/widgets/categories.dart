import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_animation/views/food_detail_view.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> categoryWidgets() => [];

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CATEGORY",
          style:
              GoogleFonts.lato(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: size.height * 0.2,
          child: Wrap(
            children: [
              ...categories.map((e) {
                int index = categories.indexOf(e);
                return Padding(
                  padding: const EdgeInsets.only(right: 17.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(45),
                        decoration: BoxDecoration(
                            color: categories[index]["color"],
                            shape: BoxShape.circle),
                        child: const Text("   "),
                      ),
                      // food and price
                      Column(
                        children: [
                          Text(
                            categories[index]["name"],
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "\$${categories[index]["price"]}",
                                style: GoogleFonts.lato(
                                    color: const Color(0xfffb5151),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "/kg",
                                style: GoogleFonts.lato(color: Colors.grey))
                          ]))
                        ],
                      ),
                    ],
                  ),
                )
                    .animate()
                    .slideY(
                      begin: 5,
                      duration: Duration(
                        milliseconds: 400 * (index + 1),
                      ),
                      curve: Curves.easeOut,
                    )
                    .fadeIn(
                      begin: 0.1,
                      delay: Duration(
                        milliseconds: 200 * (index + 1),
                      ),
                    );
              })
            ],
          ),
        ),
      ],
    );
  }
}
