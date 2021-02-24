import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/common/constants/size_constants.dart';
import 'package:my_music/presentation/theme/colors.dart';

Widget customAppBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: Sizes.dimen_12, vertical: Sizes.dimen_10),
    child: Column(
      children: [
        SizedBox(
          height: Get.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Music",
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RawMaterialButton(
                    fillColor: klightDark,
                    elevation: 9,
                    constraints: BoxConstraints.tight(Size(36, 36)),
                    shape: CircleBorder(),
                    child: Icon(Icons.search),
                    onPressed: () {}),
                // SizedBox(width: 10,),
                RawMaterialButton(
                    constraints: BoxConstraints.tight(Size(36, 36)),
                    fillColor: klightDark,
                    elevation: 9,
                    shape: CircleBorder(),
                    child: Icon(Icons.add),
                    onPressed: () {}),
              ],
            )
          ],
        ),
      ],
    ),
  );
}
