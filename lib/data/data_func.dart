import 'app_data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'temp_data.dart';

Box <HighScoreData> box = Hive.box <HighScoreData> ("highScoreData");
bool? newHighScore;

void initHighScore() {
  box.add(
    HighScoreData(
      addHighScore: 0,
      subHighScore: 0,
      mulHighScore: 0,
      divHighScore: 0,
      mixHighScore: 0,
    )
  );
}

int isHigher(int currHS, int newS) {
  if (newS > currHS) {
    newHighScore = true;
    return newS;
  }

  return currHS;
}

void updateHighScore() async {
  HighScoreData? currHS = box.get(0);
  await box.put(0, HighScoreData(
      addHighScore: isHigher(currHS!.addHighScore, TempData.addScore!),
      subHighScore: isHigher(currHS.subHighScore, TempData.subScore!),
      mulHighScore: isHigher(currHS.mulHighScore, TempData.mulScore!),
      divHighScore: isHigher(currHS.divHighScore, TempData.divScore!),
      mixHighScore: isHigher(currHS.mixHighScore, TempData.mixScore!),
    )
  );
}