import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:better_world/logic/CreditCardBloc.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/widget/ProfileTile.dart';
import 'package:better_world/view/HomePage.dart';
import 'package:better_world/widget/CommonScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TODO : Send card data to platform
class CreditCardPage extends StatelessWidget {
  static const platform = const MethodChannel('betterWorld.org/payment');
  /* platform.invokeMethod('addSource', <String, dynamic>{
      number: '0000 0000 0000 0000',
      exp: 12/20,
      cvc: 333,
     });
   */

  BuildContext _context;
  CreditCardBloc cardBloc;
  MaskedTextController ccMask = MaskedTextController(mask: "0000 0000 0000 0000");
  MaskedTextController expMask = MaskedTextController(mask: "00/00");
  MaskedTextController cvcMask = MaskedTextController(mask: "000");
  CreditCardPage({Key key, @required this.user}) : super(key: key);

  final FirebaseUser user;

  Widget bodyData() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[creditCardWidget(), fillEntries()],
    ),
  );

  Widget creditCardWidget() {
    var deviceSize = MediaQuery.of(_context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: UIData.kitGradients)),
              ),
              Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/map.png",
                  fit: BoxFit.cover,
                ),
              ),
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                child: cardEntries(),
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccStripe,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  stream: cardBloc.nameOutputStream,
                  initialData: "Your Name",
                  builder: (context, snapshot) => Text(
                    snapshot.data.length > 0 ? snapshot.data : "Your Name",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: UIData.ralewayFont,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<String>(
            stream: cardBloc.ccOutputStream,
            initialData: "**** **** **** ****",
            builder: (context, snapshot) {
              snapshot.data.length > 0
                  ? ccMask.updateText(snapshot.data)
                  : null;
              return Text(
                snapshot.data.length > 0
                    ? snapshot.data
                    : "**** **** **** ****",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              );
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
                stream: cardBloc.expOutputStream,
                initialData: "MM/YY",
                builder: (context, snapshot) {
                  snapshot.data.length > 0
                      ? expMask.updateText(snapshot.data)
                      : null;
                  return ProfileTile(
                    textColor: Colors.white,
                    title: "Expiry",
                    subtitle:
                    snapshot.data.length > 0 ? snapshot.data : "MM/YY",
                  );
                }),
            SizedBox(
              width: 30.0,
            ),
            StreamBuilder<String>(
                stream: cardBloc.cvvOutputStream,
                initialData: "***",
                builder: (context, snapshot) => ProfileTile(
                  textColor: Colors.white,
                  title: "CVV",
                  subtitle:
                  snapshot.data.length > 0 ? snapshot.data : "***",
                )),
          ],
        ),
      ],
    ),
  );

  Widget fillEntries() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: ccMask,
          keyboardType: TextInputType.number,
          maxLength: 19,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
          decoration: InputDecoration(
              labelText: "Numéro de carte bancaire",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              border: OutlineInputBorder()),
        ),
        TextField(
          controller: expMask,
          keyboardType: TextInputType.number,
          maxLength: 5,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          onChanged: (out) => cardBloc.expInputSink.add(expMask.text),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "MM/YY",
              border: OutlineInputBorder()),
        ),
        TextField(
          controller: cvcMask,
          keyboardType: TextInputType.number,
          maxLength: 3,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          onChanged: (out) => cardBloc.cvvInputSink.add(cvcMask.text),
          decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "CVC",
              border: OutlineInputBorder()),
        ),
        TextField(
          keyboardType: TextInputType.text,
          maxLength: 20,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          onChanged: (out) => cardBloc.nameInputSink.add(out),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Nom",
              border: OutlineInputBorder()),
        ),
      ],
    ),
  );

  Widget myBottomBar(BuildContext context) => BottomAppBar(
    clipBehavior: Clip.antiAlias,
    shape: CircularNotchedRectangle(),
    child: Ink(
      height: 50.0,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: UIData.kitGradients2)),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: double.infinity,
            child: new InkWell(
              radius: 10.0,
              splashColor: Colors.yellow,
              onTap: () {
                platform.invokeMethod('addSource', <String, dynamic>{
                  "number": ccMask.text,
                  "exp": expMask.text,
                  "cvc": cvcMask.text,
                });
                user.getIdToken().then( (value) => print(value));
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    HomePage(user : this.user, isOnboarding: false, title: "Better World")));
              },
              child: Center(
                child: new Text(
                  "Continuer",
                  style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    _context = context;
    cardBloc = CreditCardBloc();
    return CommonScaffold(
      appTitle: "Informations Bancaires",
      bodyData: bodyData(),
      elevation: 0.0,
      showBottomNav: true,
      customBottomBar: myBottomBar(context),
    );
  }
}