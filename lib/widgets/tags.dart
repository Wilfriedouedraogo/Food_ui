import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_animation/views/food_detail_view.dart';
import 'package:google_fonts/google_fonts.dart';

class Tags extends StatelessWidget {
  const Tags({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TAG",
          style:
              GoogleFonts.lato(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            const Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            ...tags.map((e) {
              int index = tags.indexOf(e);
              return Container(
                margin: const EdgeInsets.only(bottom: 10, right: 10),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 13,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: e["isSelected"] == false
                        ? const Color(0xff444c59)
                        : const Color(0xfffb5151)),
                child: Text(
                  e["name"],
                  style: GoogleFonts.lato(color: Colors.white),
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
        )
      ],
    );
  }
}
