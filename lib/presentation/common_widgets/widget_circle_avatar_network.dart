import 'package:flutter/material.dart';

class CircleAvatarNetwork extends StatelessWidget {
  final String imageUrl;
  final double size;

  const CircleAvatarNetwork({
    Key key,
    @required this.imageUrl,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
