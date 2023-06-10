import 'package:flutter/material.dart';
import 'question_and_answer.dart';
import 'quiz_page.dart';

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

  late List <bool> chooseLevel = [false, false, false, false];
  late List <String> textLevel = ["Addition", "Substraction", "Multiplication", "Division"];

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 179, 177, 177),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.7,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 103, 103, 103),
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Choose Question Type",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ),
                ),
              ),
              Container(
                height: height * 0.1,
                width:  width * 0.7,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith((states) {
                            return states.contains(MaterialState.pressed) ? Colors.grey : null;
                          }),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(height),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(Size((width * 0.35) - 4, height * 0.1)),
                        ),
                        onPressed: () {
                          setState(() {
                            chooseLevel[index] = !chooseLevel[index];
                            if (chooseLevel[index]) {
                              questionAnswer.chosenOperation.add(index);
                            }
                            else {
                              questionAnswer.chosenOperation.remove(index);
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: height * 0.005),
                          child: Stack(
                            children: [
                                Center(
                                  child: Text(
                                  textLevel.elementAt(index),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                                ),
                              ),
                        
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 250),
                                  opacity: chooseLevel[index] ? 1 : 0,
                                  child: const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ); 
                  }),
                ),
              ),
              Container(
                height: height * 0.1,
                width:  width * 0.7,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith((states) {
                            return states.contains(MaterialState.pressed) ? Colors.grey : null;
                          }),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(height),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(Size((width * 0.35) - 4, height * 0.1)),
                        ),
                        onPressed: () {
                          setState(() {
                            chooseLevel[index + 2] = !chooseLevel[index + 2];
                            if (chooseLevel[index + 2]) {
                              questionAnswer.chosenOperation.add(index + 2);
                            }
                            else {
                              questionAnswer.chosenOperation.remove(index + 2);
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: height * 0.005),
                          child: Stack(
                            children: [
                                Center(
                                  child: Text(
                                  textLevel.elementAt(index + 2),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                                ),
                              ),
                        
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 250),
                                  opacity: chooseLevel[index + 2] ? 1 : 0,
                                  child: const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ); 
                  }),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    return states.contains(MaterialState.pressed) ? Colors.grey : null;
                  }),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(height),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(Size(width * 0.7, height * 0.1)),
                ),
                onPressed: () {
                  if (questionAnswer.chosenOperation.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Choose at least 1 question type", textAlign: TextAlign.center,),
                        duration: const Duration(milliseconds: 1000),
                        width: width * 0.75,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                    );
                  }
                  else {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(toQuizPage());
                  }
                },
                child: Center(
                  child: Text(
                    "Play",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}