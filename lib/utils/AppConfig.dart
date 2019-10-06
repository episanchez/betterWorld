import 'package:flutter/material.dart';

class AppConfig {
  double width;
  double height;
  double blockSize;
  double blockSizeVertical;

  AppConfig(BuildContext context){
    this.width = MediaQuery.of(context).size.width;
    this.height = MediaQuery.of(context).size.height;
    this.blockSize = width / 100;
    this.blockSizeVertical = height / 100;
  }
}