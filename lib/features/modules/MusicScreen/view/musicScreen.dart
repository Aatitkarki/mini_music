import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_music/common/ui_helper.dart';
import 'package:my_music/features/modules/MusicScreen/controller/musicScreenController.dart';
import 'package:my_music/features/modules/MusicScreen/view/dragablesheet.dart';
import 'package:my_music/theme/colors.dart';

class MusicHomePage extends StatelessWidget {
  GlobalKey _dragabbleScrollableKey = GlobalKey<ScaffoldState>();
  final MusicScreenController musicScreenController =
      Get.put(MusicScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          customAppBar(context),
          Divider(
            height: 2,
            color: kDarkBlack,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              child: Text("Songs"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Playlists"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Artists"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Genres"),
              onPressed: () {},
            ),
          ]),
          Divider(
            height: 2,
            color: kDarkBlack,
          ),
          SongsList(musicScreenController: musicScreenController,key: _dragabbleScrollableKey,),
        ]),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      padding: mPagePadding,
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

}

class SongsList extends StatelessWidget {
  const SongsList({
    Key key,
    @required this.musicScreenController,
  }) : super(key: key);

  final MusicScreenController musicScreenController;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GetBuilder<MusicScreenController>(builder: (_) {
      return musicScreenController.songsList == null
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SpinKitRotatingCircle(
                    color: kViolet,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Please wait while the song is loading")
                ]))
          : Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: musicScreenController.songsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: kLightBlue,
                        child: Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "${musicScreenController.songsList[index].title}",
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(Icons.more_vert_outlined)
                          ],
                        ));
                  },
                ),

                musicScreenController.isStopped?                
                DraggableScrollableSheet(
                  key: key,
                  
                  initialChildSize: 0.15,
                  minChildSize: 0.15,
                  maxChildSize: 1,
                  expand: true,
                  
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      height: 350,
                      color: Colors.green,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          
                        ),
                      ),
                    );
                  },
                ):
                Container()
              ],
            );
    }));
  }
}
