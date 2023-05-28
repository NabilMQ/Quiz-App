import 'package:flutter/material.dart';
import 'question_and_answer.dart';

class ScoreQuestion extends StatefulWidget {
  const ScoreQuestion({ Key? key }) : super(key: key);

  @override
  State <ScoreQuestion> createState() => _ScoreQuestionState();
}

class _ScoreQuestionState extends State <ScoreQuestion> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        height: height * 0.4,
        child: Column(
          children: [
            SizedBox(
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: UnconstrainedBox(
                  child: Container(
                    padding: EdgeInsets.all(height * 0.0075),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.025),
                    color: Colors.white,
                  ),
                    child: Text(
                      "Score: ${questionAnswer.score}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.275,
              width: width,
              margin: EdgeInsets.only(top: height * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.025),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "${questionAnswer.first} ${questionAnswer.operation} ${questionAnswer.second}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}