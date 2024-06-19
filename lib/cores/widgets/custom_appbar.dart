import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/helpers/extensions.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.cast,
            color: Colors.black,
            size: 23,
          ),
        ),
        const SizedBox(width: 4),
        const Padding(
          padding: EdgeInsets.only(left: 14, right: 7),
          child: Icon(
            Icons.search,
            color: Colors.black,
            size: 23,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 22,
          ),
        ),
        const SizedBox(width: 6)
      ],
    );
  }
}
