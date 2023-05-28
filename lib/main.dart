import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'question_and_answer.dart';
import 'store_data.dart';
import 'dart:async';

StreamController <int> streamController  = StreamController <int> (); // to refresh the page from another file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _Home(streamController.stream, savedHighScore: StoreHighScore(),),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home(this.stream, {Key? key, required this.savedHighScore}) : super(key: key);

  final Stream stream;
  final StoreHighScore savedHighScore;

  @override
  State <_Home> createState() => _HomePage();
}

class _HomePage extends State <_Home> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) { // to refresh the page from another file
      refreshHome();
    });

    widget.savedHighScore.readHighScore().then((value) { // get highscore from local file
      if (value == 0) { // if the file is not created or the value of highscore is 0, the file is created
        widget.savedHighScore.createFile();
      }

      setState(() { // else, get the highscore from the local file
        questionAnswer.highscore = value;
      });
    });
    
  }

  void refreshHome() { // refresh homepage
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 177, 177),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.075,
              margin: EdgeInsets.all(height * 0.015),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height * 0.03),
                  bottomRight: Radius.circular(height * 0.03),
                  topRight: Radius.circular(height * 0.03),
                  bottomLeft: Radius.circular(height * 0.03),
                ),
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  "Quiz App",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
              ),
            ),
      
            SizedBox(
              height: height * 0.80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      fixedSize: MaterialStateProperty.all(Size(width * 0.5, height * 0.1)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(toQuizPage());
                    },
                    child: const Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(height * 0.015),
                    child: Text(
                      "Highscore: ${questionAnswer.highscore}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}