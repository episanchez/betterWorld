import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:better_world/widget/bank_card.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/utils/AppConfig.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key key, @required this.user}) : super(key: key);
  final FirebaseUser user;
  final List<BankCardModel> cards = [
    BankCardModel('assets/bg_red_card.png', 'Hoang Cuu Long',
        '4221 5168 7464 2283', '08/20', 10000000),
    BankCardModel('assets/bg_red_card.png', 'Hoang Cuu Long',
        '4221 5168 7464 2283', '08/20', 10000000),
  ];

  Widget getRowText(String label, String value) {
    TextEditingController te = new TextEditingController(text: value);

    return new Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: te,
            decoration: InputDecoration(labelText: label),

            enabled: true,
            style: TextStyle(
                fontWeight:
                FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget Account(BuildContext context) {
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
                decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(25.0),),
                child: bodyData(context)
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
                      top: config.blockSizeVertical * 2.4,
                      child: ClipOval(
                        child: Container(
                          color: UIData.actColor,
                          width: 9,
                          height: 9,
                        ),)
                  ),
                  Positioned(
                      right: config.blockSize * 13.5,
                      top: config.blockSizeVertical * 2,
                      child: ClipOval(
                        child: Container(
                          color: UIData.actColor,
                          width: 13,
                          height: 13,
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

  Widget bodyData(BuildContext context) {
   return Container(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
         Padding(
             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
             child: Row(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child: Icon(Icons.person),
                 ),
                 Text('Mes Informations Personnelles',
                   style: TextStyle(fontWeight: FontWeight.w700),)
               ],
             )
         ),
         Container(
           child: Expanded(
             child: ListView.builder(
                 itemCount: 2,
                 itemBuilder: (BuildContext context, int index) {
                   if (index == 0) {
                     return Container(
                       margin: EdgeInsets.only(left: 16.0, right: 16.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: <Widget>[
                           Container(
                             //margin: EdgeInsets.only(top: 8.0),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.stretch,
                                 children: <Widget>[
                                   Padding(
                                       padding: const EdgeInsets.only(bottom: 16.0),
                                       child: getRowText("Name", "Luo Shang")
                                   ),
                                   Padding(
                                       padding:
                                       const EdgeInsets.only(bottom: 16.0),
                                       child: getRowText("Date de Naissance","22/04/1992")
                                   ),
                                   Padding(
                                       padding:
                                       const EdgeInsets.only(bottom: 16.0),
                                       child: getRowText("Email", "longhoang.2984@gmail.com")
                                   ),
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                     );
                   } else {
                     return _userBankCardsWidget(context);
                   }
                 }),
           ),
         ),
       ],
     ),
   ); 
  }

  Widget _userBankCardsWidget(BuildContext context) {
    AppConfig config = AppConfig(context);

    var size = config.blockSize * 40;
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.account_balance),
                  ),
                  Text('Mes Informations Bancaires',
                    style: TextStyle(fontWeight: FontWeight.w700),)
                ],
              )
          ),
          GridView.count(crossAxisCount: size > 320 ? 2 : 1,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: (152 / 92),
            controller: new ScrollController(keepScrollOffset: false),
            children: List.generate(cards.length, (index) {
              return _getBankCard(context, index);
            }),),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(16.0),
                height: 50.0,
                decoration: BoxDecoration(
                    color: UIData.attentionColor,
                    borderRadius: BorderRadius.all(Radius.circular(11.0))),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Valider',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getBankCard(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SmallBankCard(card: cards[index], screenWidth: MediaQuery.of(context).size.width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Account(context);
  }

}
