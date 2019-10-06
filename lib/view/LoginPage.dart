import 'package:flutter/material.dart';
import 'package:better_world/utils/AppConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:better_world/widget/googleSignInButton.dart';
import 'package:better_world/view/HomePage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:better_world/widget/CommonScaffold.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  //TODO : Implement Auth with phone number

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _currentCaroussel = 0;

  final List<NetworkImage> imgList = [
    new NetworkImage('https://www.tuxboard.com/photos/2013/11/fondation-abbe-pierre-pancartes-sourire-.jpg'),
    new NetworkImage('http://www.quozzy.fr/wp-content/uploads/2013/11/41.jpg'),
    new NetworkImage('https://www.tuxboard.com/photos/2013/11/un-sourire-SVP-pancartes-640x426.jpg'),
    new NetworkImage('http://1.bp.blogspot.com/-qkqVlfxzMWM/UpJh8p82GyI/AAAAAAAACL4/Uvj3wEZHlNc/s1600/1454739_10152012789685255_319546694_n.jpg'),
    new NetworkImage('https://media.paperblog.fr/i/688/6888140/photographies-decalees-sur-sans-abris-T-GMYB84.jpeg'),
    new NetworkImage('https://images.ecosia.org/Jg9S1FPxuE1YSsNBMabrmG0hoBU=/0x390/smart/http%3A%2F%2Fwww.indigne-du-canape.com%2Fwp-content%2Fuploads%2F2013%2F12%2Fun-sourire-svp-une-exposition-signee-luigi-li-et-little-shao00.jpg')
  ];

  Future<FirebaseUser> _SignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

  //create full screen Carousel with context

  Widget bodyData(BuildContext context){
    AppConfig config = AppConfig(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: config.blockSizeVertical * 12,
          left: config.blockSize * 20,
            right: config.blockSize * 20,
          child: Image.asset('assets/BW-logo.png', scale: 4)
        ),
        Positioned(
            top: config.blockSizeVertical * 35,
            //Builder needed to provide mediaQuery context from material app
            child: Builder(builder: (context) {
              return new SizedBox(
                  height: config.blockSizeVertical * 40,
                  width: config.blockSize * 100,
                  child: new Carousel(
                      showIndicator: false,
                    images: [
                      new NetworkImage('https://www.tuxboard.com/photos/2013/11/fondation-abbe-pierre-pancartes-sourire-.jpg'),
                      new NetworkImage('http://www.quozzy.fr/wp-content/uploads/2013/11/41.jpg'),
                      new NetworkImage('https://www.tuxboard.com/photos/2013/11/un-sourire-SVP-pancartes-640x426.jpg'),
                      new NetworkImage('http://1.bp.blogspot.com/-qkqVlfxzMWM/UpJh8p82GyI/AAAAAAAACL4/Uvj3wEZHlNc/s1600/1454739_10152012789685255_319546694_n.jpg'),
                      new NetworkImage('https://media.paperblog.fr/i/688/6888140/photographies-decalees-sur-sans-abris-T-GMYB84.jpeg'),
                      new NetworkImage('https://images.ecosia.org/Jg9S1FPxuE1YSsNBMabrmG0hoBU=/0x390/smart/http%3A%2F%2Fwww.indigne-du-canape.com%2Fwp-content%2Fuploads%2F2013%2F12%2Fun-sourire-svp-une-exposition-signee-luigi-li-et-little-shao00.jpg')
                    ]
                  )
              );
            })),
        Positioned(
            top: config.blockSizeVertical * 77,
            left: config.blockSize * 15,
            right: config.blockSize * 15,
            child: GoogleSignInButton(
                onPressed: () {
                  _SignInWithGoogle().then((fireBaseUser) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: fireBaseUser, title: "BetterWorld",)));
                  });
                }
            )
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Better World",
      bodyData: bodyData(context),
      elevation: 0.0,
      showAppBar: false,
      showBottomNav: false,
      showDrawer: false,
      showFAB: false,
    );
  }
}