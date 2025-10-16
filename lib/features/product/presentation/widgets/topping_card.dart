import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ToppingCard({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            5,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Material(
                  elevation: 8,

                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 90,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xff3C2F2F),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Row(
                              children: [
                                CustomText(
                                  text: text,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: onTap,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    radius: 10,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 90,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        child: Image.asset(
                          "assets/test/to.png",
                          height: 55,
                          width: 55,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
