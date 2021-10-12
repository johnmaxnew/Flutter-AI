import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oz/model/radio.dart';
import 'package:oz/utils/ai_util.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<MyRadio> radios;

  get itemBuilder => null;

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    // ignore: avoid_print
    print(radios);

    setState(() {
      
    });
  }

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
            title: 'OZ Radio'.text.xl4.bold.white.make().shimmer(primaryColor: Vx.purple300, secondaryColor: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(110.0).p16(),
          VxSwiper.builder(
            itemCount: radios.length,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            itemBuilder: (context, index){
              final rad = radios[index];

              return VxBox(
                // ignore: prefer_const_constructors
                child: ZStack([
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack([
                      rad.name.text.xl3.white.bold.make(),
                    ]),
                  )
                ]))
              .bgImage(DecorationImage(image: NetworkImage(rad.image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              ))
              .withRounded(value: 60.0)
              .make()
              .p16()
              .centered();
            },
           )
        ],
        fit: StackFit.expand,
      ),
    );
  }
}