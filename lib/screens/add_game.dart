import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fidigames/model/game_model.dart';
import 'package:fidigames/providers/game_provider.dart';
import 'package:fidigames/screens/utils/constants.dart';
import 'package:fidigames/widgets/FidiGameForm.dart';
import 'package:fidigames/widgets/fididropDown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGame extends StatefulWidget {
  AddGame({Key? key}) : super(key: key);
  static const routeName = "/addGame";

  @override
  _AddGameState createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  TextEditingController gameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController gameUrlController = TextEditingController();
  TextEditingController minCountController = TextEditingController();
  TextEditingController maxCountController = TextEditingController();

  String currentCategory = "Action";
  File? imageFile;

  Future<void> _pickedImage() async {
    final _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (_pickedImage == null) {
      return;
    }
    setState(() {
      imageFile = File(pickedImage!.path);
    });

// add .path to this to start the device path
    // var devicePath = await sysPath.getApplicationDocumentsDirectory();

    // var fileName = path.basename(imageFile!.path);

    // var storeName = await imageFile!.copy("${devicePath.path}/$fileName");
    // widget.storeImageFile(storeName);
  }

  Future<void> _submitGame() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("gameImage")
        .child(gameController.text + ".jpg");

    await ref.putFile(imageFile!);

    final url = await ref.getDownloadURL();
    log(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    Provider.of<GameProvider>(context, listen: false)
        .addNewGame(Game(
            id: userId!,
            name: gameController.text,
            description: descriptionController.text,
            gameUrl: gameUrlController.text,
            minCount: minCountController.text,
            maxCount: maxCountController.text,
            category: currentCategory,
            imageUrl: url == null ? " " : url,
            isFav: false))
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Game added successfully.'),
        ),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var object = Provider.of<GameProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.mainTextColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Add a game',
                      style: AppTheme.textDisplayedStyleMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'Name of the Game',
                  style: AppTheme.addPageDisplayedStyleSmallest,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FidiForm("Enter game name", gameController, 48.0, 369.0, 1,
                    (value) {
                  if (value!.isEmpty) {
                    return " Please enter game name";
                  }

                  value = gameController.text;
                  return '';
                }, false),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Description',
                  style: AppTheme.addPageDisplayedStyleSmallest,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FidiForm(
                    "Enter Description", descriptionController, 126.0, 369.0, 5,
                    (value) {
                  if (value!.isEmpty) {
                    return " Please enter game description";
                  }
                  value = descriptionController.text;
                  return '';
                }, false),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Game URL',
                  style: AppTheme.addPageDisplayedStyleSmallest,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FidiForm("www.... ", gameUrlController, 48.0, 369.0, 1,
                    (value) {
                  if (value!.isEmpty) {
                    return " Please enter game Url";
                  }
                  value = gameUrlController.text;
                  return '';
                }, false),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Players Count',
                  style: AppTheme.addPageDisplayedStyleSmallest,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      'Minimum count',
                      style: AppTheme.addPageDisplayedStyleSmallest,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.formColor),
                      child: TextFormField(
                          controller: minCountController,
                          cursorColor: AppTheme.mainTextColor,
                          style: TextStyle(color: AppTheme.mainTextColor),
                          decoration: InputDecoration(
                              isDense: true, // important line
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none))),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      'Maximum count',
                      style: AppTheme.addPageDisplayedStyleSmallest,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppTheme.formColor),
                      child: TextField(
                        controller: maxCountController,
                        cursorColor: AppTheme.mainTextColor,
                        style: TextStyle(color: AppTheme.mainTextColor),
                        decoration: InputDecoration(
                            isDense: true, // important line
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Category',
                  style: AppTheme.addPageDisplayedStyleSmallest,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                AppDropdownInput(
                  hintText: "Categories",
                  options: object.categories,
                  value: currentCategory,
                  onChanged: (String? value) {
                    setState(() {
                      currentCategory = value!;
                      // state.didChange(newValue);
                      object.storeCategories(currentCategory);
                    });
                  },
                  getLabel: (String value) => value,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                imageFile == null
                    ? GestureDetector(
                        onTap: _pickedImage,
                        child: Container(
                          height: 48.0,
                          width: 369.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: AppTheme.formColor),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.file_upload,
                                  color: AppTheme.textColor,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Upload an image',
                                  style: AppTheme.addPageDisplayedStyleSmallest,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            color: AppTheme.textColor,
                            borderRadius: BorderRadius.circular(10.0),
                            image:
                                DecorationImage(image: FileImage(imageFile!))),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.buttonColor),
                        child: TextButton(
                          onPressed: _submitGame,
                          child: Text(
                            "submit",
                            style: AppTheme.textDisplayedStyleSmallest.copyWith(
                                color: AppTheme.formColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
