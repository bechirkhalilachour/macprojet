import 'package:flutter/material.dart';

class DetailChip extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String data;

  const DetailChip(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            color: Color(0xFFE46472),
            size: 18.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(data,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ],
    );
  }
}
