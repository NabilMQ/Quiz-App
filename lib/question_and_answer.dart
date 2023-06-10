import 'dart:math';

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
  static int score = 0;
  static int highscore = 0;
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