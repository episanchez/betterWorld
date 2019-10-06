import 'package:flutter/material.dart';
import 'package:better_world/logic/model/UserForm.dart';
import 'package:better_world/logic/model/Address.dart';
import 'package:better_world/logic/UserInterface.dart';
import 'package:better_world/widget/CommonScaffold.dart';
import 'package:better_world/view/CreditCardPage.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalForm extends StatefulWidget {
  @override
  PersonalFormState createState() {
    return PersonalFormState(user);
  }

  final FirebaseUser user;
  PersonalForm({Key key, @required this.user}) : super(key: key);
}

class PersonalFormState extends State<PersonalForm> {
  final _formKey = GlobalKey<FormState>();
  FirebaseUser user;
  String _firstName;
  String _lastName;
  String _birthDate;
  String _email;
  String _phone;
  String _AddressLine;
  String _AddressPostalCode;
  String _city;
  PersonalFormState(this.user);

  Widget bodyData() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Form(
            key: _formKey,
            child: FormWidget()
        )],
    ),
  );

  Widget FormWidget() => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
          Row(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(right: 12.0),
              width: 165,
                child: TextFormField(
                  onSaved: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                  initialValue: user.displayName.split(" ")[1],
                  keyboardType: TextInputType.text,
                  maxLength: 19,
                  style: TextStyle(
                    fontFamily: UIData.ralewayFont, color: Colors.black),
                  decoration: InputDecoration(
                  labelText: "Nom",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()
              )
            )
            ),
    Container(
      width: 165,
      child: TextFormField(
          onSaved: (value) {
            setState(() {
              _firstName = value;
            });
          },
          initialValue: user.displayName.split(" ")[0],
          keyboardType: TextInputType.text,
              maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Prénom",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
              )
            )
    ),
      ],
        ),
          TextFormField(
            onSaved: (value) {
              setState(() {
                _birthDate = value;
              });
            },
          keyboardType: TextInputType.datetime,
          maxLength: 8,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Date de Naissance (DD/MM/YYYY)",
              border: OutlineInputBorder()),
        ),
          TextFormField(
            onSaved: (value) {
              setState(() {
                _phone = value;
              });
            },
          keyboardType: TextInputType.phone,
          initialValue: user.phoneNumber,
          maxLength: 12,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Numéro de téléphone",
              border: OutlineInputBorder()),
        ),
          TextFormField(
            onSaved: (value) {
              setState(() {
                _email = value;
              });
            },
          initialValue: user.email,
          keyboardType: TextInputType.emailAddress,
          maxLength: 30,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "Email",
              border: OutlineInputBorder()),
        ),
        TextFormField(
          onSaved: (value) {
            setState(() {
              _AddressLine = value;
            });
          },
          maxLength: 30,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "Adresse",
              border: OutlineInputBorder()),
        ),
          TextFormField(
            onSaved: (value) {
              setState(() {
                _AddressPostalCode = value;
              });
            },
          keyboardType: TextInputType.emailAddress,
          maxLength: 5,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "Code postale",
              border: OutlineInputBorder()),
        ),
          TextFormField(
            onSaved: (value) {
              print("saved 3 :");
              setState(() {
                print("saved : " + value);
                _city = value;
              });
            },
          keyboardType: TextInputType.text,
          maxLength: 30,
          style: TextStyle(
              fontFamily: UIData.ralewayFont, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "Ville",
              border: OutlineInputBorder()),
        ),
        // Add Address input
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
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world, you'd
                  // often want to call a server or save the information in a database
                  _formKey.currentState.save();
                  UserInterface interface = new UserInterface();
                  Address address = Address(line1: _AddressLine, line2: "", postalCode: _AddressPostalCode, city: _city, country: "France");
                  UserForm userForm = UserForm(firstName: _firstName, lastName: _lastName,
                      //birthDate: DateTime.parse(_birthDate),
                      phone: _phone, email: _email, address: address);
                  interface.postUserForm(user.uid, userForm);
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCardPage(user: this.user)));
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
    return CommonScaffold(
      appTitle: "Informations Personnelles",
      bodyData: bodyData(),
      elevation: 0.0,
      showBottomNav: true,
      customBottomBar: myBottomBar(context),
    );
  }
}