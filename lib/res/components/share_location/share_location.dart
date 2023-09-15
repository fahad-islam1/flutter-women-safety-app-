import 'package:flutter/material.dart';
import 'package:women_safety_app/res/components/share_location/bottomsheat.dart';

import '../../colors/colors.dart';

class ShareLocation extends StatelessWidget {
  const ShareLocation({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: () {
          showBottomSheets(context);
      
        },
        child: Card(
            elevation: 5,
            color: white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: size.width,
              height: 180,
              child: Row(
                children: [
                  const Expanded(
                    child: ListTile(
                      title: Text(
                        'Send Location',
                      ),
                      subtitle: Text(
                        'Share Location',
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/route.jpg',
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
