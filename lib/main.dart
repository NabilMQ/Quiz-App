import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_1/data/app_data.dart';
import 'chooseLevelPage/level.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_1/data/data_func.dart';
import 'package:project_1/data/audio_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter <HighScoreData> (HighScoreDataAdapter());
  await Hive.openBox <HighScoreData> ("highScoreData");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 28,
            color: Colors.white,
            letterSpacing: 1.25,
          ),
          headlineMedium: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1.25,
          ),
          titleLarge: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 28,
            color: Color.fromARGB(255, 110, 108, 255),
            letterSpacing: 1.25,
          ),
          titleMedium: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 21,
            color: Color.fromARGB(255, 110, 108, 255),
            letterSpacing: 1.25,
          ),
          titleSmall: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 12,
            color: Color.fromARGB(255, 110, 108, 255),
            letterSpacing: 1.25,
          ),
          bodyLarge: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 10,
            color: Color.fromARGB(255, 110, 108, 255),
            letterSpacing: 1.25,
          ),
          labelLarge: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 18,
            color: Color.fromARGB(255, 110, 108, 255),
            letterSpacing: 1.25,
          ),

          labelMedium: TextStyle(
            fontFamily: "OCRAEXT",
            fontSize: 14,
            color: Color.fromARGB(255, 110, 108, 255),
            letterSpacing: 1.25,
          ),
        ),
      ),
      home: const _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  State <_Home> createState() => _HomePage();
}

class _HomePage extends State <_Home> with SingleTickerProviderStateMixin{  

  SvgPicture _startButton = SvgPicture.asset(
      "assets/svg/play_button.svg",
      key: const ValueKey(0),
      width: double.infinity,
      fit: BoxFit.cover,
    );
  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    if (box.values.isEmpty) {
      initHighScore();
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/svg/simple_linear_bg.svg",
            width: width,
            height: height,
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.075,
                  margin: EdgeInsets.all(height * 0.015),
                  child: Center(
                    child: Text(
                      "Quiz App",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                
                SizedBox(
                  height: height * 0.80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.5,
                        height: width * 0.5,
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (!_clicked) {
                              playChangePageSound();
                              setState(() {
                                _clicked = true;
                                _startButton = SvgPicture.asset(
                                  "assets/svg/play_button_inverted.svg",
                                  key: const ValueKey(1),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                                Navigator.of(context).push(toLevelPage());
                                Future.delayed(const Duration(milliseconds: 1000), () {
                                  setState(() {
                                    _clicked = false;
                                    _startButton = SvgPicture.asset(
                                      "assets/svg/play_button.svg",
                                      key: const ValueKey(0),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  });
                                });
                              });
                            }
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _startButton,
                          ),
                        ),
                      ),
                  
                      Container(
                        margin: EdgeInsets.all(height * 0.015),
                        child: Text(
                          "Play",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}