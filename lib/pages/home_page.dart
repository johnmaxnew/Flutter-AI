import 'package:flutter/material.dart';
import 'package:oz/utils/ai_util.dart';
// import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      drawer: const Drawer(),
    );
  }
}