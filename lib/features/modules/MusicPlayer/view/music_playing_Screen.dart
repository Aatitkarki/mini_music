import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/common/ui_helper.dart';
import 'package:my_music/features/modules/MusicScreen/controller/musicScreenController.dart';
import 'package:my_music/theme/colors.dart';

class MusicPlayingScreen extends StatelessWidget {
  final MusicScreenController controller = Get.find();
  final int index;

  MusicPlayingScreen({ this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            customAppBar(context),
            Divider(
              height: 2,
              color: kDarkBlack,
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      width: Get.width,
      padding: sYPagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RawMaterialButton(
                  fillColor: klightDark,
                  elevation: 9,
                  constraints: BoxConstraints.tight(Size(36, 36)),
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  }),
              // SizedBox(width: 10,),
              Text(
                "Now Playing",
                style: Theme.of(context).textTheme.headline4,
              ),

              RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(36, 36)),
                  fillColor: klightDark,
                  elevation: 9,
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                  onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
