import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/res/utils/qoutes.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2,
        viewportFraction: 0.98,
        autoPlay: true,
        enlargeFactor: 0.5,
        enlargeCenterPage: true,
      ),
      items: List.generate(imageSliders.length, (index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: imageSliders[index],
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) {
                        return const Icon(
                            Icons.error); // Replace with actual error widget
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black.withOpacity(.5),
                        Colors.transparent,
                      ]),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7, bottom: 3),
                        child: Text(
                          articleTitle[index],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// class CustomSlider extends StatelessWidget {
//   const CustomSlider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//         options: CarouselOptions(
//             aspectRatio: 2,
//             viewportFraction: .98,
//             autoPlay: true,
//             enlargeFactor: 0.5,
//             enlargeCenterPage: true),
//         items: List.generate(imageSliders.length, (index) {
//           return Card(
//             elevation: 5,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: CachedNetworkImageProvider(imageSliders[index]),
//                 onError: (context,  error) {
//                   return ; // Replace with actual error widget
//                 },
               
//               ),
//             ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: LinearGradient(colors: [
//                     Colors.black.withOpacity(.5),
//                     Colors.transparent
//                   ]),
//                 ),
//                 child: Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 7, bottom: 3),
//                       child: Text(
//                         articleTitle[index],
//                         style: TextStyle(
//                             fontSize: MediaQuery.of(context).size.width * 0.06,
//                             // fontWeight: FontWeight.bold,
//                             color: white),
//                       ),
//                     )),
//               ),
//             ),
//           );
//         }));
//   }
// }


//  CachedNetworkImage(
//                     imageUrl: imageSliders[index],
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),