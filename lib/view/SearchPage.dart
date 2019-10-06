import 'package:flutter/material.dart';
import 'package:better_world/widget/CommonScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:better_world/utils/AppConfig.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/widget/ProfileTile.dart';
import 'package:better_world/view/PersonalForm.dart';
import 'package:better_world/view/ProfilePage.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, @required this.user, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final FirebaseUser user;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  BuildContext _context;
  int current_step = 0;

  @override
  Widget bodyData(BuildContext context) {
    AppConfig config = AppConfig(context);
    _context = context;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
      return Stack(
        overflow: Overflow.clip,
        children: [
          Positioned(
              left: config.blockSize * 24.8,
              right: config.blockSize * 24.54,
              top: config.blockSizeVertical * 6.5,
              //bottom: config.blockSizeVertical * 6.4,,
              child: new Container(
                width: config.blockSize * 40,
                child: Image.asset("assets/logo_one-line.png")
              )
          ),
          Positioned(
            left: config.blockSize * 20,
            right: config.blockSize * 20,
            top: config.blockSizeVertical * 36,
            child: new Text('Recherchez par ID', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          Positioned(
            left: config.blockSize * 6,
            right: config.blockSize * 6,
            top: config.blockSizeVertical * 42,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  //filterSearchResults(value);
                },
                onSubmitted: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ProfilePage(user: widget.user)
                  ));
                },
                decoration: InputDecoration(
                    fillColor: UIData.actColor,
                    labelText: "Rechercher",
                    hintText: "Saisissez ici l'ID de la personne",
                    prefixIcon: Icon(Icons.search, color: UIData.actColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),

          ),
          ]
    );
  }
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "",
      showAppBar: false,
      backGroundColor: UIData.attentionColor,
      bodyData: bodyData(context),
      elevation: 0.0,
      showBottomNav: false,
    );
  }
}