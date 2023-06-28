import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_1/data/data_func.dart';
import 'package:project_1/data/temp_data.dart';
import 'package:project_1/quizPage/question_and_answer.dart';
import 'answer_button.dart';
import 'quiz_page.dart';

class AdditionOperation extends StatefulWidget {
  const AdditionOperation({ Key? key }) : super(key: key);

  @override
  State <AdditionOperation> createState() => _AdditionOperationState();
}

class _AdditionOperationState extends State<AdditionOperation> {

  bool _clicked = false;
  late List <String> labelText;

  final List <String> _answerBg = [
    "assets/svg/button_bg_blue.svg",
    "assets/svg/button_bg_blue.svg",
    "assets/svg/button_bg_blue.svg",
    "assets/svg/button_bg_blue.svg",
  ];
  final List <ValueKey <int>> _key = [
    const ValueKey(0),
    const ValueKey(0),
    const ValueKey(0),
    const ValueKey(0),
  ];

  @override
  void initState() {
    super.initState();
    labelText = [
      "Game Over",
      "Score: ${TempData.addScore}",
      "New HighScore!",
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _clicked = false;
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height; 

    return Column(
      children: [
        SizedBox(
          width: width,
          height: height * 0.075,
          child: Text(
            "Score: ${TempData.addScore}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),

        SizedBox(
          width: width,
          height: height * 0.325,
          child: Text(
            "${questionAnswer.first} ${questionAnswer.operation} ${questionAnswer.second}",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),

        FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: width,
            height: height * 0.6,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: width * 0.4375,
                  height: height * 0.25,
                  margin: EdgeInsets.only(
                    top: width * 0.05,
                    bottom: width * 0.05,
                    left: width * 0.025,
                    right: width * 0.025
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (!_clicked) {
                        setState(() {
                          if (isAnswerCorrect(_clicked, index)) {
                            _clicked = true;
                            questionAnswer.trueOrFalse[index] = 1;
                            TempData.addScore = TempData.addScore! + 1;
                            _answerBg[index] = "assets/svg/button_bg_green.svg";
                            _key[index] = const ValueKey(1);
                            Future.delayed(const Duration(milliseconds: 1500), () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(toQuizPage());
                            });
                          }
                          else {
                            _clicked = true;
                            updateHighScore();
                            questionAnswer.trueOrFalse[index] = 0;
                            _answerBg[index] = "assets/svg/button_bg_red.svg";
                            _key[index] = const ValueKey(1);
                            Future.delayed(const Duration(milliseconds: 1000), () => showDialog(
                              context: context,
                              barrierDismissible: false,
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
                                            height: height * 0.1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: List.generate(newHighScore! ? 3 : 2, (index) => Text(labelText.elementAt(index), style: Theme.of(context).textTheme.labelLarge)),
                                            )
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: height * 0.035),
                                            height: height * 0.1,
                                            child: Center(
                                              child: Container(
                                                width: width * 0.525,
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
                                                      "Back To Menu",
                                                      style: Theme.of(context).textTheme.labelLarge,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          }
                        });
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: AnswerButton(
                        key: _key[index],
                        bg: _answerBg[index],
                        answer: questionAnswer.answerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)).toString(),
                        answerStyle: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}