import 'package:flutter/material.dart';
import 'package:better_world/widget/CommonScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:better_world/utils/AppConfig.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/view/AccountPage.dart';

class DonationPage extends StatefulWidget {
  DonationPage({Key key, @required this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final FirebaseUser user;
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _pageController = new PageController();
  final _formKey = GlobalKey<FormState>();
  BuildContext _context;
  double _amount;
  String dropdownValue = 'XXXX-XXXX-XXXX-XX23';
  int current_step = 0;

  List<Widget> getPages(BuildContext context) {
    return <Widget>[
      Donation(context),
      AccountPage(user: widget.user)
    ];
  }

  Widget bodyData(BuildContext context){
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
  @override
  Widget Donation(BuildContext context) {
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
                          left: config.blockSize * 23,
                          right: config.blockSize * 23,
                          top: config.blockSizeVertical * 5,
                          child: new Text('FAIRE UN DON', style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                        Positioned(
                          left: config.blockSize * 8,
                          right: config.blockSize * 8,
                          top: config.blockSizeVertical * 12,
                          child: new Text('Merci de bien vérifier les informations avant de confirmer votre don.', style: TextStyle(fontSize: 15, color: Colors.black)),
                        ),
                        Form(
                          key: _formKey,
                          child: Stack(
                            children: [
                              Positioned(
                                left: config.blockSize * 8,
                                right: config.blockSize * 8,
                                top: config.blockSizeVertical * 22,
                                child: Container(
                                  height: config.blockSizeVertical * 8,
                                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: new BorderRadius.circular(25.0)),
                                  child:Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4")
                                      ), SizedBox(width: 10),Text("Robert", style: TextStyle(fontSize: 18),)
                                    ],
                                  )
                                ),
                              ),
                              Positioned(
                                left: config.blockSize * 8,
                                right: config.blockSize * 8,
                                top: config.blockSizeVertical * 33,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder (
                                        borderRadius: new BorderRadius.circular(25.0),
                                        //borderSide: new BorderSide(),
                                      ),
                                      labelText: "De : ",
                                      hintText: 'Saisissez un montant',
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      suffixIcon:Icon(Icons.euro_symbol, color: UIData.attentionColor)

                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez saisir le montant';
                                    }
                                  },
                                  onSaved: (String val) {
                                    _amount = double.parse(val);
                                  },
                                ),
                              ),
                              Positioned(
                                left: config.blockSize * 8,
                                right: config.blockSize * 8,
                                top: config.blockSizeVertical * 47,
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>["XXXX-XXXX-XXXX-XX23",
                                  "XXXX-XXXX-XXXX-XX42"]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.credit_card),
                                            SizedBox(width: 10),
                                            Text(value
                                            ),
                                          ],
                                        ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Positioned(
                                left: config.blockSize * 8,
                                right: config.blockSize * 8,
                                top: config.blockSizeVertical * 61,
                                child: Container(
                                  height: config.blockSizeVertical * 7,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(17.0)),
                                  color: UIData.attentionColor,
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, we want to show a Snackbar
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                                    }
                                  },
                                  child: Text('CONFIRMER', style: TextStyle(color: Colors.white),),
                                ),
                                ),
                              ),
                            ]
                          ),
                        ),

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
            )
          ]
      );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "",
      showAppBar: false,
      backGroundColor: UIData.backgroundGrey,
      bodyData: bodyData(context),
      elevation: 0.0,
      showBottomNav: false,
    );
  }
}
