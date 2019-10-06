import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/utils/AppConfig.dart';
import 'package:better_world/view/AccountPage.dart';
import 'package:better_world/view/DonationPage.dart';
import 'package:better_world/widget/CommonScaffold.dart';
import 'package:better_world/widget/card/easyBadgeCard.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, @required this.user}) : super(key: key);

  final FirebaseUser user;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _pageController = new PageController();

  List<Widget> getPages(BuildContext context) {
    return <Widget>[
      Profile(context),
      AccountPage(user: widget.user)
    ];
  }

  Widget Profile(BuildContext context) {
    AppConfig config = AppConfig(context);

    return Stack(
        overflow: Overflow.clip,
        children: [
          Positioned(
              bottom: config.blockSizeVertical * 75,
              child: new Container(
                //width: config.blockSize * 40,
                  child: Image.asset("assets/guy.jpg", fit: BoxFit.cover)
              )
          ),
          Positioned(
            left: config.blockSize * 6.4,
            right: config.blockSize * 6.4,
            top: config.blockSizeVertical * 18.29,
            bottom: config.blockSizeVertical * 9.6,
            child: Container(
                decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(25.0),),
                child: Stack(
                  children: [
                    Positioned(
                      top: config.blockSizeVertical * 2,
                      left: config.blockSize * 33,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text("Robert", style: TextStyle(fontSize: 20))],
                      )
                    ),
                    Positioned(
                      top: config.blockSizeVertical * 7,
                      left: config.blockSize * 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(Icons.location_on), Text("Paris", style: TextStyle(fontSize: 15))],
                       )
                     ),
                    Positioned(
                        top: config.blockSizeVertical * 12,
                        left: config.blockSize * 13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[Text("30 ans, dans la rue depuis 2 ans.", style: TextStyle(fontSize: 15))],
                        )
                    ),
                    Positioned(
                      top: config.blockSizeVertical * 12,
                      left: config.blockSize * 3,
                      right: config.blockSize * 3,
                      child: Container(
                            height: config.blockSizeVertical * 45,
                            width: config.blockSize * 74,
                            child: profileTabBarView(config)
                        )
                    ),
                    Positioned(
                        top: config.blockSizeVertical * 62,
                        left: config.blockSize * 8,
                        right: config.blockSize * 8,
                        child: Container(
                          height: config.blockSizeVertical * 7,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(17.0)),
                            color: UIData.attentionColor,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DonationPage(user: widget.user)));
                            },
                            child: Text('FAIRE UN DON', style: TextStyle(color: Colors.white),),
                        )
                      )
                    )

                  ]
                )
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
          )
        ]
    );
  }

  Widget profileTabBarView(AppConfig config) => DefaultTabController(
    length: 3,
    child: ListView(
      children: <Widget>[
        Container(
            height: config.blockSizeVertical * 12,
            width: config.blockSize * 74,
          child: TabBar(
            labelColor: Colors.green[500],
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.person), text: "Histoire"),
              Tab(icon: Icon(Icons.business_center), text: "Compétences"),
              Tab(icon: Icon(Icons.add_shopping_cart), text: "Besoins")
            ],
          )
        ),
        Container(
          height: config.blockSizeVertical * 30,
          width: config.blockSize * 74,
            child: TabBarView(
              children: [
                UserStory(),
                UserSkills(),
                UserNeed(),
              ],
            ),
        ),
      ],
    ),
  );

  Widget UserStory() => Center(
    child: ListView(
      children: <Widget>[Text(
      "Auparavant, j'avais une vie tout ce qu'il y avait de plus normal, je travaillais dans le BTP et j'avais deux magnifiques bouts de choux. Il y a un an, ma femme est décédé, son décès m'a énormément affecté, je suis tombé peu à peu dans la dépression puis il y a un mois, j'ai perdu mon emploi et mon logement. J'espère rebondir pour revoir mes deux trésors ..."
      , style: TextStyle(fontSize: 15.0)
      )],
    )
  );

  Widget UserSkills() => ListView(
            children : <Widget>[
              new EasyBadgeCard(
                leftBadge: Colors.white,
                title: 'BTP',
                description: 'Batiment',
                backgroundColor: Colors.green[500],
                prefixIcon: Icons.business,
                prefixIconColor: Colors.green[500],
                suffixIconColor: Colors.white,
                titleColor: Colors.white,
                descriptionColor: Colors.white,
              ),
              new EasyBadgeCard(
                leftBadge: Colors.white,
                title: 'Compta',
                description: 'Moi j\'adore les chiffres',
                backgroundColor: Colors.green[500],
                prefixIcon: Icons.exposure_plus_1,
                prefixIconColor: Colors.green[500],
                suffixIconColor: Colors.white,
                titleColor: Colors.white,
                descriptionColor: Colors.white,
              ),
            ]
  );

  Widget UserNeed() => ListView(
          children : <Widget>[
            new EasyBadgeCard(
              leftBadge: Colors.white,
              title: 'Nourritures',
              description: "",
              backgroundColor: Colors.green[500],
              prefixIcon: Icons.fastfood,
              prefixIconColor: Colors.green[500],
              suffixIconColor: Colors.white,
              titleColor: Colors.white,
              descriptionColor: Colors.white,
            ),
            new EasyBadgeCard(
              leftBadge: Colors.white,
              title: 'Logement',
              description: '',
              backgroundColor: Colors.green[500],
              prefixIcon: Icons.home,
              prefixIconColor: Colors.green[500],
              suffixIconColor: Colors.white,
              titleColor: Colors.white,
              descriptionColor: Colors.white,
            ),
          ]
  );

  Widget bodyData() {
    return new PageView.builder(
      physics: new ClampingScrollPhysics(),
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        List<Widget> pages = getPages(context);
        return pages[index % pages.length];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "",
      backGroundColor: UIData.whiteColor,
      showAppBar: false,
      bodyData: bodyData(),
      elevation: 0.0,
      showBottomNav: false,
      //customBottomBar: DonationButton(context),
    );
  }
}