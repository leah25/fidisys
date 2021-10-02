import 'package:fidigames/model/game_model.dart';
import 'package:fidigames/providers/game_provider.dart';
import 'package:fidigames/screens/add_game.dart';
import 'package:fidigames/screens/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static const routeName = "/homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownvalue = 'Adventure';
  bool _init = true;
  bool _isLoading = false;

  List<Game> filteredGameList = [];

  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<GameProvider>(context).fetchGames().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var gameObject = Provider.of<GameProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                'Fidigame',
                style: AppTheme.textDisplayedStyleMedium,
              ),
              categoryDropDown(gameObject),
              filteredGameList.length == null
                  ? Center(
                      child: Text(
                        'No Game Added',
                        style: AppTheme.textDisplayedStyleSmall,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: filteredGameList.length,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                Container(
                                  height: 148,
                                  width: 369,
                                  decoration: BoxDecoration(
                                    color: AppTheme.formColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0,
                                                right: 22.0,
                                                top: 22.0,
                                                bottom: 2.0),
                                            child: Container(
                                              height: 72,
                                              width: 72,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.textColor,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          filteredGameList[
                                                                  index]
                                                              .imageUrl),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      filteredGameList[index]
                                                              .isFav =
                                                          !filteredGameList[
                                                                  index]
                                                              .isFav;
                                                    });
                                                  },
                                                  icon: filteredGameList[index]
                                                          .isFav
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: AppTheme
                                                              .buttonColor,
                                                          size: 15,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: AppTheme
                                                              .textColor,
                                                          size: 15,
                                                        )),
                                              Text(
                                                '240',
                                                style: TextStyle(
                                                    color: AppTheme.textColor,
                                                    fontSize: 12),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Text(
                                              filteredGameList[index].name,
                                              style: AppTheme
                                                  .textDisplayedStyleMedium,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            Text(
                                              filteredGameList[index]
                                                  .description,
                                              style: AppTheme
                                                  .textDisplayedStyleSmallest
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color:
                                                          AppTheme.textColor),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    height: 32,
                                                    width: 88,
                                                    decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .backgroundColor,
                                                        border: Border.all(
                                                            color: AppTheme
                                                                .buttonColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Center(
                                                      child: TextButton.icon(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.play_arrow,
                                                            color: AppTheme
                                                                .mainTextColor,
                                                            size: 14,
                                                          ),
                                                          label: Text(
                                                            "Play",
                                                            style: AppTheme
                                                                .textDisplayedStyleSmallest
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          )),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.people_alt_outlined,
                                                      color: AppTheme.textColor,
                                                      size: 10.12,
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                      "${filteredGameList[index].minCount} - ${filteredGameList[index].maxCount} Players",
                                                      style: AppTheme
                                                          .textDisplayedStyleSmallest
                                                          .copyWith(
                                                              color: AppTheme
                                                                  .textColor,
                                                              fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                )
                              ],
                            );
                          }),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 200,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.buttonColor),
        child: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, AddGame.routeName);
          },
          label: Text(
            "Add Game",
            style: AppTheme.textDisplayedStyleSmallest.copyWith(
                color: AppTheme.formColor, fontWeight: FontWeight.bold),
          ),
          icon: Icon(
            Icons.add,
            color: AppTheme.backgroundColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget categoryDropDown(GameProvider gameObject) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        height: 32,
        width: 135,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.textColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppTheme.formColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              value: dropdownvalue,
              underline: SizedBox(),
              icon: Icon(Icons.keyboard_arrow_down),
              items: gameObject.categories.map((String items) {
                return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(color: AppTheme.textColor),
                    ));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownvalue = value!;
                  filteredGameList =
                      gameObject.productsByCategory(dropdownvalue);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
