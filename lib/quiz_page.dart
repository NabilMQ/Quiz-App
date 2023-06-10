import 'package:flutter/material.dart';
import 'score_question.dart';
import 'question_and_answer.dart';
import 'main.dart';
import 'store_data.dart';
import 'dart:io';

Route toQuizPage() {

  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) => Quiz(savedHighScore: StoreHighScore(),),
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
  const Quiz({Key? key, required this.savedHighScore}) : super(key: key);

  final StoreHighScore savedHighScore;

  @override
  State <Quiz> createState() => HalamanQuiz();
}

class HalamanQuiz extends State <Quiz> {

  bool answerSelected = false;

  @override
  void initState() {
    super.initState();
    newQuestion();
  }

  @override
  void dispose() {
    super.dispose();
    questionAnswer.trueOrFalse = [2, 2, 2, 2];
    answerSelected = false;
  }

  void newQuestion() { // create new question
    changeQuestion();
    getAnswer();
    setState(() {
      questionAnswer.trueOrFalse = [2, 2, 2, 2];
    });
  }

  Future <File> saveHighScore() {
    return widget.savedHighScore.writeHighScore(questionAnswer.highscore);
  }

  Future deleteHighScore() async {
    questionAnswer.score = 0;
    return widget.savedHighScore.deleteFile();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
      Colors.white
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height * 0.025),
        ),
      ),
      fixedSize: MaterialStateProperty.all(Size.fromHeight(height * 0.08))
    );

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height * 0.025),
            ),
            content: Container(
              height: height * 0.2,
              padding: EdgeInsets.all(height * 0.0005),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Center(
                    child: Text(
                      "Are you sure want to exit?\n(The progress will not be saved)",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        resetQuiz();
                      });
                      deleteHighScore();
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                    }, 
                    child: const Text("Exit")
                  ),
                ],
              ),
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 179, 177, 177),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(height * 0.015),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const ScoreQuestion(),
                SizedBox(
                  height: height * 0.5,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      if (questionAnswer.randomizeOperation == 3) {
                        return ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            setState(() {
                              if (answerSelected == false && checkAnswer(questionAnswer.divisionAnswerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)))) {
                                answerSelected = true;
                                questionAnswer.trueOrFalse[index] = 1;
                                questionAnswer.score++;
                                Future.delayed(const Duration(milliseconds: 1500), () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(toQuizPage());
                                });
                              }
                              else if (answerSelected == false) {
                                answerSelected = true;
                                if (questionAnswer.score > questionAnswer.highscore) {
                                  questionAnswer.highscore = questionAnswer.score;
                                }
                                questionAnswer.trueOrFalse[index] = 0;
                                questionAnswer.score = 0;
                                saveHighScore();
                                Future.delayed(const Duration(milliseconds: 1000), () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(height * 0.025),
                                    ),
                                    content: Container(
                                      height: height * 0.2,
                                      padding: EdgeInsets.all(height * 0.0005),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "Game Over",
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                resetQuiz();
                                              });
                                              Navigator.of(ctx).pop();
                                              Navigator.of(context).pop();
                                              streamController.add(index);
                                            }, 
                                            child: const Text("Go back")
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                              }
                            });
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Center(
                                child: Text(
                                  questionAnswer.first.toInt() % questionAnswer.second.toInt() == 0 ? questionAnswer.divisionAnswerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)).toStringAsFixed(0) : questionAnswer.divisionAnswerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)).toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                  
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 500),
                                    crossFadeState: questionAnswer.trueOrFalse.elementAt(index) == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                    firstChild: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.black,
                                    ),
                                    secondChild: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 500),
                                    crossFadeState: questionAnswer.trueOrFalse.elementAt(index) == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                    firstChild: const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    secondChild: const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      else {
                        return ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            setState(() {
                              if (answerSelected == false && checkAnswer(questionAnswer.answerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)))) {
                                answerSelected = true;
                                questionAnswer.trueOrFalse[index] = 1;
                                questionAnswer.score++;
                                Future.delayed(const Duration(milliseconds: 1500), () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(toQuizPage());
                                });
                              }
                              else if (answerSelected == false) {
                                answerSelected = true;
                                if (questionAnswer.score > questionAnswer.highscore) {
                                  questionAnswer.highscore = questionAnswer.score;
                                }
                                questionAnswer.trueOrFalse[index] = 0;
                                questionAnswer.score = 0;
                                saveHighScore();
                                Future.delayed(const Duration(milliseconds: 1000), () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(height * 0.025),
                                    ),
                                    content: Container(
                                      height: height * 0.2,
                                      padding: EdgeInsets.all(height * 0.0005),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "Game Over",
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                              Navigator.of(context).pop();
                                              streamController.add(index);
                                            }, 
                                            child: const Text("Go back")
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                              }
                            });
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Center(
                                child: Text(
                                  questionAnswer.answerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)).toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                  
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 500),
                                    crossFadeState: questionAnswer.trueOrFalse.elementAt(index) == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                    firstChild: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.black,
                                    ),
                                    secondChild: const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 500),
                                    crossFadeState: questionAnswer.trueOrFalse.elementAt(index) == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                    firstChild: const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    secondChild: const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}