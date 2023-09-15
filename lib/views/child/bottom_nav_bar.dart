import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_app/res/colors/colors.dart';
import 'package:women_safety_app/view_model/bottom_navbar_view_model.dart';

class BottomNavPagesScreen extends StatelessWidget {
  const BottomNavPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .01),
        width: displayWidth,
        height: displayWidth * .16,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: controller.listOfIcons.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              controller.changeIndex(index);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Obx(
              () => Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == controller.currentIndex.value
                        ? displayWidth * .32
                        : displayWidth * .16,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == controller.currentIndex.value
                          ? displayWidth * .12
                          : 0,
                      width: index == controller.currentIndex.value
                          ? displayWidth * .32
                          : 0,
                      decoration: BoxDecoration(
                        color: index == controller.currentIndex.value
                            ? primaryColor.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == controller.currentIndex.value
                        ? displayWidth * .32
                        : displayWidth * .16,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == controller.currentIndex.value
                                  ? displayWidth * .13
                                  : 0,
                            ),
                            AnimatedOpacity(
                              opacity: index == controller.currentIndex.value
                                  ? 1
                                  : 0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                index == controller.currentIndex.value
                                    ? '${controller.listOfStrings[index]}'
                                    : '',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == controller.currentIndex.value
                                  ? displayWidth * .03
                                  : 20,
                            ),
                            Icon(
                              controller.listOfIcons[index],
                              size: displayWidth * .076,
                              color: index == controller.currentIndex.value
                                  ? primaryColor
                                  : primaryColor.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
