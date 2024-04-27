import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final int id;
  final String url;

  const PhotoWidget({
    Key? key,
    required this.id,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Photo Url from API doesn't work
    int num = id % 18 + 1;
    String randomDefaultPhoto = 'assets/profile_pic/$num.jpg';

    return CircleAvatar(
        radius: 30.0,
        child: ClipOval(
          child: Image.asset(randomDefaultPhoto),
        ));
  }
}
