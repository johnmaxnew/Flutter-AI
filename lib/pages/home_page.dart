import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oz/model/radio.dart';
import 'package:oz/utils/ai_util.dart';
import 'package:velocity_x/velocity_x.dart';


// import 'package:ai_radio/model/radio.dart';
// import 'package:ai_radio/utils/ai_util.dart';
// import 'package:alan_voice/alan_voice.dart';



class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<MyRadio> radios;
  MyRadio _selectedRadio;
  Color _selectedColor;
  bool _isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();


  @override
  void initState() {
    super.initState();
    fetchRadios();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    // ignore: avoid_print
    print(radios);

    setState(() {});
  }

  _playMusic(String url){
    _audioPlayer.play(url);
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    print(_selectedRadio.name);

    setState(() {});
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

                  // Positioned(
                  //   top: 0.0,
                  //   right: 0.0,
                  //   child: VxBox(
                  //     child: rad.category.text.uppercase.white.bold.make().px16(),
                  //   ).height(40).alignCenter.make(),
                  // ),


                  Align(
                    alignment: Alignment.topCenter,

                    child: VxBox(
                      child: rad.category.text.uppercase.white.bold.make().px16(),
                    ).height(40).width(100).alignCenter.black.withRounded(value: 10.0).make().py16(),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack([
                      rad.name.text.xl3.white.bold.make(),
                      5.heightBox,
                      rad.tagline.text.sm.white.semiBold.make()
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      CupertinoIcons.play_circle,
                      color: Colors.white,
                    ),
                  ),
                ]))
              .bgImage(DecorationImage(image: NetworkImage(rad.image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              ))
              .withRounded(value: 60.0)
              .make()
              .onInkDoubleTap(() {
                
              })
              .p16();
            },
           ).centered(),
            Align(
             alignment: Alignment.bottomCenter,
             child: [

               if(_isPlaying)
               "Playing Now - ${_selectedRadio.name}".text.makeCentered(),
               Icon(
               _isPlaying
                    ? CupertinoIcons.stop_circle
                    : CupertinoIcons.play_circle,               
                  color: Colors.white,
                  size: 50.0,
                ).onInkTap(() {
                  if(_isPlaying){
                    _audioPlayer.stop();
                  }else{
                    _playMusic(_selectedRadio.url);
                  }
                 })
             ].vStack(),
           ).pOnly(bottom: context.percentHeight * 12),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}