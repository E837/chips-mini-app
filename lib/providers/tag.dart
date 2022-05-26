import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tag with ChangeNotifier {
  final String label;
  bool isLiked;
  bool isWaiting = false;

  Tag({
    required this.label,
    required this.isLiked,
  });

  void toggleFav() {
    isLiked = !isLiked;
    notifyListeners();
  }

  void toggleWaiting() {
    isWaiting = !isWaiting;
    notifyListeners();
  }
}

class Tags with ChangeNotifier {
  final List<Tag> _tags = [];

  Future<void> addTag(String label) async {
    final prefs = await SharedPreferences.getInstance();
    final newTag = Tag(
      label: label,
      isLiked: false,
    );
    _tags.add(newTag);
    final tagsData = json.encode(_jsonify());
    prefs.setString('tagsData', tagsData);
    notifyListeners();
  }

  List<Map<String, dynamic>> _jsonify() {
    return _tags
        .map((tag) => {
              'label': tag.label,
              'isLiked': tag.isLiked,
            })
        .toList();
  }

  Future<void> loadTagsData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('tagsData')) {
      return;
    }

    _tags.clear();
    final tagsData = json.decode(prefs.getString('tagsData')!);
    for (Map<String, dynamic> tData in tagsData) {
      _tags.add(Tag(
        label: tData['label'],
        isLiked: tData['isLiked'],
      ));
    }
    notifyListeners();
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _tags.clear();
    notifyListeners();
  }

  List<Tag> get getTags => List.unmodifiable(_tags);
}
