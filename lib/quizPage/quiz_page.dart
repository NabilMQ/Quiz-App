import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'question_and_answer.dart';

Route toQuizPage() {

  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) => const Quiz(),
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

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State <Quiz> createState() => HalamanQuiz();
}

class HalamanQuiz extends State <Quiz> {

  @override
  void initState() {
    super.initState();
    newQuestion();
  }

  @override
  void dispose() {
    super.dispose();
    questionAnswer.trueOrFalse = [2, 2, 2, 2];
  }

  void newQuestion() { // create new question
    changeQuestion();
    getAnswer();
    setState(() {
      questionAnswer.trueOrFalse = [2, 2, 2, 2];
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (ctx) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: width * 0.175),
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.05),
            ),
            content: SizedBox(
              height: height * 0.25,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(height * 0.05),
                    child: SvgPicture.asset(
                      "assets/svg/alert_bg.svg",
                      width: width,
                      fit: BoxFit.fill,
                      clipBehavior: Clip.antiAlias,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: height * 0.15,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.025),
                            child: Text("Are you sure want to exit?\n(The progress will not be saved)", style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
                          ),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: height * 0.015),
                        height: height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                width: width * 0.25,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Center(
                                    child: Text(
                                      "No",
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Center(
                              child: Container(
                                width: width * 0.25,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text(
                                      "Yes",
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              "assets/svg/simple_linear_bg.svg",
              width: width,
            ),
            
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Builder(
                  builder: (context) {
                    return returnPage();
                  },
                )
              ),
            ),
          ]
        ),
      ),
    );
  }
}