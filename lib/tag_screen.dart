import 'dart:async';

import 'package:flutter/material.dart';

import 'package:chips_mini_app/providers/tag.dart';
import 'package:provider/provider.dart';

class TagScreen extends StatelessWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Provider.of<Tag>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Center(
              child: Text(
                tag.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: tag.isWaiting
                  ? null
                  : () {
                      tag.toggleWaiting();
                      Timer(const Duration(seconds: 2), () {
                        tag.toggleFav();
                        tag.toggleWaiting();
                      });
                    },
              icon: Icon(
                tag.isLiked ? Icons.favorite : Icons.favorite_border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
