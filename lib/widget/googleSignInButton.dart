import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function onPressed;

  GoogleSignInButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
      onPressed: () => this.onPressed(),
      color: Colors.white,
      elevation: 0.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/glogo.png",
            height: 18.0,
            width: 18.0,
          ),
          SizedBox(width: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Se Connecter avec Google",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}