import 'package:flutter/material.dart';
import 'package:oz/utils/ai_util.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:velocity_x/velocity_x.dart';

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
      body: Stack(
        children: [
          VxAnimatedBox().size(context.screenWidth, context.screenHeight)
          .withGradient(LinearGradient(
            colors: [
              AIColors.primaryColor1,
              AIColors.primaryColor2
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ))
          .make(),
          AppBar(
            title: 'OZ Radio'.text.xl4.bold.white.make(),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ).h(110.0).p16()
        ],
      ),
    );
  }
}