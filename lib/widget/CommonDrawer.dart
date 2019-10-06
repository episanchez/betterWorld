import 'package:flutter/material.dart';
import 'package:better_world/view/AccountPage.dart';

class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child : Center(
              child : UserAccountsDrawerHeader(
                accountName: Text(
                  "Charlie Quillard",
                  textAlign: TextAlign.center,
                ),
                accountEmail: Text(
                  "charlie.quillard@gmail.com",
                ),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new AssetImage("assets/guy.jpg"),

                ),
              ),
            ),

          ),
          new ListTile(
            title: Text(
              "Mon Compte",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountPage()));
            },
            leading: Icon(
              Icons.account_circle,
              color: Colors.red,
            ),
          ),
          Divider(),
          new ListTile(
            title: Text(
              "A propos",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              Icons.info,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}