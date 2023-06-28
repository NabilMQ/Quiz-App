import 'package:flutter/material.dart';
import 'level_button.dart';
import 'package:project_1/quizPage/question_and_answer.dart';
import 'package:project_1/data/app_data.dart';

mixin level {
  static HighScoreData? currHS;
  static TextStyle buttonTitle = const TextStyle(
    fontFamily: "OCRAEXT",
    fontSize: 12,
    color: Color.fromARGB(255, 110, 108, 255),
    letterSpacing: 1.25,
  );
  static TextStyle buttonBody = const TextStyle(
    fontFamily: "OCRAEXT",
    fontSize: 10,
    color: Color.fromARGB(255, 110, 108, 255),
    letterSpacing: 1.25,
  );
  static Widget? additionButton;
  static Widget? substractionButton; 
  static Widget? multiplicationButton;
  static Widget? divisionButton;
  static Widget? mixButton;
}

void toAddition() {
  questionAnswer.chosenOperation.add(0);
}

void toSubstraction() {
  questionAnswer.chosenOperation.add(1);
}

void toMultiplication() {
  questionAnswer.chosenOperation.add(2);
}

void toDivision() {
  questionAnswer.chosenOperation.add(3);
}

void toMix() {
  questionAnswer.chosenOperation.add(0);
  questionAnswer.chosenOperation.add(1);
  questionAnswer.chosenOperation.add(2);
  questionAnswer.chosenOperation.add(3);
}

void fontChanged() {
  level.buttonTitle = const TextStyle(
    fontFamily: "OCRAEXT",
    fontSize: 12,
    color: Colors.white,
    letterSpacing: 1.25,
  );
  level.buttonBody = const TextStyle(
    fontFamily: "OCRAEXT",
    fontSize: 10,
    color: Colors.white,
    letterSpacing: 1.25,
  );
}

void fontGoBack() {
  level.buttonTitle = const TextStyle(
    fontFamily: "OCRAEXT",
    fontSize: 12,
    color: Color.fromARGB(255, 110, 108, 255),
    letterSpacing: 1.25,
  );
  level.buttonBody = const TextStyle(
    fontFamily: "OCRAEXT",
    fontSize: 10,
    color: Color.fromARGB(255, 110, 108, 255),
    letterSpacing: 1.25,
  );
}

void initLevelWidget() {
  level.additionButton = LevelButton(
    key: const ValueKey(0),
    bg: "assets/svg/addition_bg.svg",
    title: "Addition",
    bodyText: "Highscore: ${level.currHS?.addHighScore}",
    titleStyle: level.buttonTitle,
    bodyStyle: level.buttonBody,
  );

  level.substractionButton = LevelButton(
    key: const ValueKey(0),
    bg: "assets/svg/substraction_bg.svg",
    title: "substraction",
    bodyText: "Highscore: ${level.currHS?.subHighScore}",
    titleStyle: level.buttonTitle,
    bodyStyle: level.buttonBody,
  );

  level.multiplicationButton = LevelButton(
    key: const ValueKey(0),
    bg: "assets/svg/multiplication_bg.svg",
    title: "Multiplication",
    bodyText: "Highscore: ${level.currHS?.mulHighScore}",
    titleStyle: level.buttonTitle,
    bodyStyle: level.buttonBody,
  );

  level.divisionButton = LevelButton(
    key: const ValueKey(0),
    bg: "assets/svg/division_bg.svg",
    title: "Division",
    bodyText: "Highscore: ${level.currHS?.divHighScore}",
    titleStyle: level.buttonTitle,
    bodyStyle: level.buttonBody,
  );

  level.mixButton = LevelButton(
    key: const ValueKey(0),
    bg: "assets/svg/mix_bg.svg",
    title: "Mix",
    bodyText: "Highscore: ${level.currHS?.mixHighScore}",
    titleStyle: level.buttonTitle,
    bodyStyle: level.buttonBody,
  );
}