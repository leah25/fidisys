import 'dart:io';

class Game {
  final String id;
  final String name;
  final String description;
  final String gameUrl;
  final String minCount;
  final String maxCount;
  final String category;
  final String imageUrl;
  bool isFav = false;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.gameUrl,
    required this.minCount,
    required this.maxCount,
    required this.category,
    required this.imageUrl,
    required this.isFav,
  });
}
