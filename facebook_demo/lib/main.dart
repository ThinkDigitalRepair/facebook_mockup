import 'package:flutter/material.dart';
import './ui/facebook_home.dart';

main(List<String> arguments) {
  runApp(new MaterialApp(
    title: "Facebook Mockup",
    home: Facebook(),
    theme: new ThemeData(
        iconTheme: new IconThemeData(color: Colors.white),
    ),
  ));
}
