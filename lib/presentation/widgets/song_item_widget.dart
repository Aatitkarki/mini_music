import 'package:flutter/material.dart';
import 'package:my_music/presentation/theme/colors.dart';

class SongItemWidget extends StatelessWidget {
  const SongItemWidget({
    Key key,
    @required this.onPressed,
    @required this.title,
  }) : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
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
                  "$title",
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 20),
              Icon(Icons.more_vert_outlined)
            ],
          )),
    );
  }
}
