import 'package:flutter/material.dart';
import 'package:better_world/utils/uidata.dart';
import 'package:better_world/widget/CommonDrawer.dart';
import 'package:better_world/widget/CustomFloat.dart';

class CommonScaffold extends StatelessWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final showAppBar;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final floatingIcon;
  final centerDocked;
  final elevation;
  final Widget customBottomBar;

  CommonScaffold(
      {this.appTitle,
        this.bodyData,
        this.showFAB = false,
        this.showDrawer = false,
        this.showAppBar = true,
        this.backGroundColor,
        this.actionFirstIcon = Icons.search,
        this.scaffoldKey,
        this.showBottomNav = false,
        this.centerDocked = false,
        this.floatingIcon,
        this.customBottomBar,
        this.elevation = 4.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: showAppBar ? AppBar(
        elevation: elevation,
        backgroundColor: Colors.blue,
        title: Text(appTitle),
        centerTitle: true,
      ) : null,
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      floatingActionButton: showFAB
          ? CustomFloat(
        builder: centerDocked
            ? Text(
          "5",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        )
            : null,
        icon: floatingIcon,
        qrCallback: () {},
      )
          : null,
      floatingActionButtonLocation: centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: showBottomNav ? customBottomBar : null,
    );
  }
}