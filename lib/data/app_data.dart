import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'app_data.g.dart';

@HiveType(typeId: 0)
class HighScoreData {
  @HiveField(0)
  int addHighScore;

  @HiveField(1)
  int subHighScore;

  @HiveField(2)
  int mulHighScore;

  @HiveField(3)
  int divHighScore;

  @HiveField(4)
  int mixHighScore;

  HighScoreData({
    required this.addHighScore,
    required this.subHighScore,
    required this.mulHighScore,
    required this.divHighScore,
    required this.mixHighScore,
  });
}