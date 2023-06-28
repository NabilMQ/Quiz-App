import 'package:flutter/material.dart';
import 'package:project_1/quizPage/mix_operation.dart';
import 'package:project_1/quizPage/multiplication_operation.dart';
import 'package:project_1/quizPage/substraction_operation.dart';
import 'dart:math';
import 'addition_operation.dart';
import 'division_operation.dart';

mixin questionAnswer { // variable used for creating question and answer
    
  static List <String> operationList = [
    "+",
    "-",  
    "x",
    "/",
  ];

  static List <int> chosenOperation = [];

  static int first = Random().nextInt(10) + 1;
  static int second = Random().nextInt(10) + 1;
  static late int randomizeOperation;
  static String operation = operationList.elementAt(randomizeOperation);

  static List <int> chooseAnswer = [0, 1, 2, 3];
  static late List <int> answerList;
  static late List <double> divisionAnswerList;
  static late int userAnswer;
  static late double userDivisionAnswer;
  static List <int> trueOrFalse = [2, 2, 2, 2];
}

void resetQuiz() {
  questionAnswer.chosenOperation.clear();
}

void changeQuestion() { // change the question while the answer is right
  questionAnswer.first = Random().nextInt(10) + 1;
  questionAnswer.second = Random().nextInt(10) + 1;
  questionAnswer.randomizeOperation = questionAnswer.chosenOperation.elementAt(Random().nextInt(questionAnswer.chosenOperation.length));
  questionAnswer.operation = questionAnswer.operationList.elementAt(questionAnswer.randomizeOperation);

  questionAnswer.chooseAnswer.shuffle();
    switch (questionAnswer.randomizeOperation) {
      case 0:
        questionAnswer.answerList = [
          questionAnswer.first + questionAnswer.second,
          questionAnswer.first + questionAnswer.second + 1,
          questionAnswer.first + questionAnswer.second + 2,
          questionAnswer.first + questionAnswer.second - 1,
        ];
        break;

      case 1:
        questionAnswer.answerList = [
          questionAnswer.first - questionAnswer.second,
          questionAnswer.first - questionAnswer.second + 1,
          questionAnswer.first - questionAnswer.second + 2,
          questionAnswer.first - questionAnswer.second - 1,
        ];
        break;

      case 2:
        questionAnswer.answerList = [
          questionAnswer.first * questionAnswer.second,
          questionAnswer.first * questionAnswer.second + 1,
          questionAnswer.first * questionAnswer.second + 2,
          questionAnswer.first * questionAnswer.second - 1,
        ];
        break;

      case 3:
        questionAnswer.divisionAnswerList = [
          questionAnswer.first / questionAnswer.second + 0.0,
          questionAnswer.first / questionAnswer.second + 1.0,
          questionAnswer.first / questionAnswer.second + 2.0,
          questionAnswer.first / questionAnswer.second - 1.0,
        ];
        break;
    }
}

bool checkAnswer(dynamic selectedAnswer) { // check user answer, whether the answer is right or wrong
  if (selectedAnswer == questionAnswer.userAnswer || selectedAnswer == questionAnswer.userDivisionAnswer) {
    return true;
  }
  else {
    return false;
  }
}

void getAnswer() {
  if (questionAnswer.randomizeOperation < 3) {
    questionAnswer.userAnswer = questionAnswer.answerList.elementAt(0); // the right answer
    questionAnswer.userDivisionAnswer = 0.0;
  }
  else {
    questionAnswer.userAnswer = 0;
    questionAnswer.userDivisionAnswer = questionAnswer.divisionAnswerList.elementAt(0);
  }
}

bool isAddition() {
  return questionAnswer.randomizeOperation == 0 && questionAnswer.chosenOperation.length == 1;
}

bool isSubstraction() {
  return questionAnswer.randomizeOperation == 1 && questionAnswer.chosenOperation.length == 1;
}

bool isMultiplication() {
  return questionAnswer.randomizeOperation == 2 && questionAnswer.chosenOperation.length == 1;
}

bool isDivision() {
  return questionAnswer.randomizeOperation == 3 && questionAnswer.chosenOperation.length == 1;
}

bool isDivisionOperation() {
  return questionAnswer.randomizeOperation == 3;
}

Widget returnPage() {
  if (isAddition()) {
    return const AdditionOperation();
  }
  else if (isSubstraction()) {
    return const SubstractionOperation();
  }
  else if (isMultiplication()) {
    return const MultiplicationOperation();
  }
  else if (isDivision()) {
    return const DivisionOperation();
  }
  else {
    return const MixOperation();
  }
}

bool isAnswerCorrect(bool answerSelected, int index) {
  if (isDivisionOperation()) {
    return answerSelected == false && checkAnswer(questionAnswer.divisionAnswerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)));
  }
  else {
    return answerSelected == false && checkAnswer(questionAnswer.answerList.elementAt(questionAnswer.chooseAnswer.elementAt(index)));
  }  
}