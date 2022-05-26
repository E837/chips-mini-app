import 'package:chips_mini_app/tag_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chips_mini_app/providers/tag.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Provider.of<Tag>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        child: Chip(
          label: Text(tag.label),
          avatar: Icon(tag.isLiked ? Icons.favorite : Icons.favorite_border),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<Tag>.value(
                value: tag,
                child: const TagScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
