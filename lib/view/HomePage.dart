import 'package:flutter/material.dart';
import 'package:better_world/widget/CommonScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:better_world/utils/AppConfig.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/widget/ProfileTile.dart';
import 'package:better_world/view/PersonalForm.dart';
import 'package:better_world/view/AccountPage.dart';
import 'package:better_world/view/SearchPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.user, this.isOnboarding = true, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final FirebaseUser user;
  final String title;
  final bool isOnboarding;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = new PageController();
  int current_step = 0;
  bool active = true;
  double activeSize = 20;

  List<Widget> getPages(BuildContext context) {
    return <Widget>[
      Home(context),
      AccountPage(user: widget.user)
    ];
  }

   Widget Home(BuildContext context) {
    AppConfig config = AppConfig(context);
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
            left: config.blockSize * 6.4,
            right: config.blockSize * 6.4,
            top: config.blockSizeVertical * 18.29,
            bottom: config.blockSizeVertical * 9.6,
            child: Container(
                decoration: new BoxDecoration(color: UIData.attentionColor, borderRadius: new BorderRadius.circular(25.0),),
                child: Stack(
                    children: [
                      Positioned(
                        left: config.blockSize * 20,
                        right: config.blockSize * 20,
                        top: config.blockSizeVertical * 18,
                        child: new Text('Recherchez par ID', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      Positioned(
                          left: config.blockSize * 20,
                          right: config.blockSize * 20,
                          top: config.blockSizeVertical * 24,
                          bottom: config.blockSizeVertical * 24,
                          child: GestureDetector(
                            onTap: () {
                              //Insert event to be fired up when button is clicked here
                              //in this case, this increments our `countValue` variable by one.
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  SearchPage()
                              ));
                            },
                            child : Container(
                                decoration: new BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: IconButton(icon: Icon(Icons.search, size: 60, color : UIData.actColor),onPressed: null, color: Colors.green)
                            ),
                          )
                      )
                    ])
            ),
          ),
          Positioned(
              left: config.blockSize * 32,
              right: config.blockSize * 32,
              top: config.blockSizeVertical * 91,
              bottom: config.blockSizeVertical * 2,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      right: config.blockSize * 25,
                      child: Icon(Icons.search, size: 40, color: UIData.actColor,)
                  ),
                  Positioned(
                      left: config.blockSize * 13.5,
                      top: config.blockSizeVertical * 2,
                      child: ClipOval(
                        child: Container(
                          color: UIData.actColor,
                          width: 13,
                          height: 13,
                        ),)
                  ),
                  Positioned(
                      right: config.blockSize * 13.5,
                      top: config.blockSizeVertical * 2.4,
                      child: ClipOval(
                        child: Container(
                          color: UIData.actColor,
                          width: 9,
                          height: 9,
                        ),)
                  ),
                  Positioned(
                      left: config.blockSize * 25,
                      child: Icon(Icons.person, size: 40, color: UIData.actColor,)
                  ),
                ],
              )
          ),
        ]
    );
  }

  @override
  Widget bodyData(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (widget.isOnboarding){
      return new PersonalForm(user: widget.user);
    }
    else{
      return new PageView.builder(
        physics: new ClampingScrollPhysics(),
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          List<Widget> pages = getPages(context);
          print(index);
          return pages[index % pages.length];
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "",
      showAppBar: false,
      backGroundColor: UIData.whiteColor,
      bodyData: bodyData(context),
      elevation: 0.0,
      showBottomNav: false,
    );
  }
}