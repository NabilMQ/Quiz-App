import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_1/data/temp_data.dart';
import 'package:project_1/quizPage/quiz_page.dart';
import 'level_button.dart';
import 'level_widget_data.dart';
import 'package:project_1/data/data_func.dart';
import 'package:project_1/quizPage/question_and_answer.dart';
import 'package:project_1/data/audio_data.dart';

Route toLevelPage() {

  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) => const Level(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin = const Offset(1.0, 0.0);
      Offset end = Offset.zero;
      Curve curve = Curves.easeInOutCirc;
      Animatable <Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    }
  );
}

class Level extends StatefulWidget {
  const Level({ Key? key }) : super(key: key);

  @override
  State <Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {

  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    questionAnswer.chosenOperation = [];
    newHighScore = false;
    level.currHS = box.get(0);
    initLevelWidget();
    initScore();
  }
  
  @override
  void dispose() {
    super.dispose();
    _clicked = false;
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        playChangePageSound();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              "assets/svg/simple_linear_bg_flipped.svg",
              width: width,
              height: height,
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
            ),
          
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(width * 0.035),
                child: Center(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          width: width * 0.4375,
                          height: height * 0.25,
                          margin: EdgeInsets.only(bottom: width * 0.05),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!_clicked) {
                                playChangePageSound();
                                setState(() {
                                  fontChanged();
                                  level.additionButton = LevelButton(
                                    key: const ValueKey(1),
                                    bg: "assets/svg/addition_bg_inverted.svg",
                                    title: "Addition",
                                    bodyText: "Highscore: ${level.currHS?.addHighScore}",
                                    titleStyle: level.buttonTitle,
                                    bodyStyle: level.buttonBody,
                                  ); 
                                  toAddition();
                                  Future.delayed(const Duration(milliseconds: 250), () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(toQuizPage());
                                    fontGoBack();
                                    level.additionButton = LevelButton(
                                    key: const ValueKey(0),
                                    bg: "assets/svg/addition_bg.svg",
                                    title: "Addition",
                                    bodyText: "Highscore: ${level.currHS?.addHighScore}",
                                    titleStyle: level.buttonTitle,
                                    bodyStyle: level.buttonBody,
                                  ); 
                                  });
                                });
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: level.additionButton,
                            ),
                          ),
                        ),
                  
                        Padding(padding: EdgeInsets.all(width * 0.025)),
                  
                        Container(
                          width: width * 0.4375,
                          height: height * 0.25,
                          margin: EdgeInsets.only(bottom: width * 0.05),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!_clicked) {
                                playChangePageSound();
                                setState(() {
                                  fontChanged();
                                  level.substractionButton = LevelButton(
                                    key: const ValueKey(1),
                                    bg: "assets/svg/substraction_bg_inverted.svg",
                                    title: "Substraction",
                                    bodyText: "Highscore: ${level.currHS?.subHighScore}",
                                    titleStyle: level.buttonTitle,
                                    bodyStyle: level.buttonBody,
                                  ); 
                                  toSubstraction();
                                  Future.delayed(const Duration(milliseconds: 250), () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(toQuizPage());
                                    fontGoBack();
                                    level.substractionButton = LevelButton(
                                      key: const ValueKey(0),
                                      bg: "assets/svg/substraction_bg.svg",
                                      title: "Substraction",
                                      bodyText: "Highscore: ${level.currHS?.subHighScore}",
                                      titleStyle: level.buttonTitle,
                                      bodyStyle: level.buttonBody,
                                    ); 
                                  });
                                });
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: level.substractionButton,
                            ),
                          ),
                        ),
                  
                        Container(
                          width: width * 0.4375,
                          height: height * 0.25,
                          margin: EdgeInsets.only(bottom: width * 0.05),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!_clicked) {
                                playChangePageSound();
                                setState(() {
                                  fontChanged();
                                  level.multiplicationButton = LevelButton(
                                    key: const ValueKey(1),
                                    bg: "assets/svg/multiplication_bg_inverted.svg",
                                    title: "Multiplication",
                                    bodyText: "Highscore: ${level.currHS?.mulHighScore}",
                                    titleStyle: level.buttonTitle,
                                    bodyStyle: level.buttonBody,
                                  ); 
                                  toMultiplication();
                                  Future.delayed(const Duration(milliseconds: 250), () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(toQuizPage());
                                    fontGoBack();
                                    level.multiplicationButton = LevelButton(
                                      key: const ValueKey(0),
                                      bg: "assets/svg/multiplication_bg.svg",
                                      title: "Multiplication",
                                      bodyText: "Highscore: ${level.currHS?.mulHighScore}",
                                      titleStyle: level.buttonTitle,
                                      bodyStyle: level.buttonBody,
                                    ); 
                                  });
                                });
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: level.multiplicationButton,
                            ),
                          ),
                        ),
                  
                        Padding(padding: EdgeInsets.all(width * 0.025)),
                  
                        Container(
                          width: width * 0.4375,
                          height: height * 0.25,
                          margin: EdgeInsets.only(bottom: width * 0.05),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!_clicked) {
                                playChangePageSound();
                                setState(() {
                                  fontChanged();
                                  level.divisionButton = LevelButton(
                                    key: const ValueKey(1),
                                    bg: "assets/svg/division_bg_inverted.svg",
                                    title: "Division",
                                    bodyText: "Highscore: ${level.currHS?.divHighScore}",
                                    titleStyle: level.buttonTitle,
                                    bodyStyle: level.buttonBody,
                                  ); 
                                  toDivision();
                                  Future.delayed(const Duration(milliseconds: 250), () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(toQuizPage());
                                    fontGoBack();
                                    level.divisionButton = LevelButton(
                                      key: const ValueKey(0),
                                      bg: "assets/svg/division_bg.svg",
                                      title: "Division",
                                      bodyText: "Highscore: ${level.currHS?.divHighScore}",
                                      titleStyle: level.buttonTitle,
                                      bodyStyle: level.buttonBody,
                                    ); 
                                  });
                                });
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: level.divisionButton,
                            ),
                          ),
                        ),
                  
                        Container(
                          width: width * 0.4375,
                          height: height * 0.25,
                          margin: EdgeInsets.only(bottom: width * 0.05),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!_clicked) {
                                playChangePageSound();
                                setState(() {
                                  fontChanged();
                                  level.mixButton = LevelButton(
                                    key: const ValueKey(1),
                                    bg: "assets/svg/mix_bg_inverted.svg",
                                    title: "Mix",
                                    bodyText: "Highscore: ${level.currHS?.mixHighScore}",
                                    titleStyle: level.buttonTitle,
                                    bodyStyle: level.buttonBody,
                                  ); 
                                  toMix();
                                  Future.delayed(const Duration(milliseconds: 250), () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(toQuizPage());
                                    fontGoBack();
                                    level.mixButton = LevelButton(
                                      key: const ValueKey(0),
                                      bg: "assets/svg/mix_bg.svg",
                                      title: "Mix",
                                      bodyText: "Highscore: ${level.currHS?.mixHighScore}",
                                      titleStyle: level.buttonTitle,
                                      bodyStyle: level.buttonBody,
                                    ); 
                                  });
                                });
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: level.mixButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.04),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Choose Level",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}