import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:fidigames/model/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<Game> _gameItems = [];

  List<Game> get gameItems {
    return [..._gameItems];
  }

  List<String> categories = [
    "Action",
    "Adventure",
    "Arcade",
    "Board",
    "Card",
    "Casino"
  ];

  Future<void> storeCategories(String currentCategory) async {
    final url = Uri.parse(
        "https://fidigame-5a225-default-rtdb.firebaseio.com/categories.json");

    final response = await http.post(url,
        body: json.encode({"categoryName": currentCategory}));

    notifyListeners();
  }

  List<Game> productsByCategory(String category) {
    final categoryElements = _gameItems
        .where(
            (object) => object.category.toLowerCase() == category.toLowerCase())
        .toList();
    notifyListeners();

    return categoryElements;
  }

  Future<void> fetchGames() async {
    final url = Uri.parse(
        "https://fidigame-5a225-default-rtdb.firebaseio.com/games.json");

    final response = await http.get(url);
    final gamesFromFirebase =
        json.decode(response.body) as Map<String, dynamic>;

    List<Game> gamesListData = [];
    if (gamesFromFirebase == null) {
      return;
    }

    gamesFromFirebase.forEach((gameid, gameData) {
      gamesListData.add(Game(
          id: gameid,
          name: gameData["name"],
          description: gameData["description"],
          gameUrl: gameData["gameUrl"],
          minCount: gameData["minCount"],
          maxCount: gameData["maxCount"],
          category: gameData["category"],
          imageUrl: gameData["imageUrl"],
          isFav: false));

      _gameItems = gamesListData;
      notifyListeners();
    });
  }

  Future<void> addNewGame(Game game) async {
    final url = Uri.parse(
        "https://fidigame-5a225-default-rtdb.firebaseio.com/games.json");

    await http
        .post(url,
            body: json.encode({
              "id": game.id,
              "name": game.name,
              "description": game.description,
              "gameUrl": game.gameUrl,
              "minCount": game.minCount,
              "maxCount": game.maxCount,
              "category": game.category,
              "imageUrl": game.imageUrl,
              "isFavorite": game.isFav,
            }))
        .then((value) {
      var newGame = Game(
          id: json.decode(value.body)["name"],
          name: game.name,
          description: game.description,
          gameUrl: game.gameUrl,
          minCount: game.minCount,
          maxCount: game.maxCount,
          category: game.category,
          isFav: false,
          imageUrl: game.imageUrl);
      _gameItems.add(newGame);
    });

    notifyListeners();
  }
}
