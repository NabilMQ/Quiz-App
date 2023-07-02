import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

mixin sound {
  static Soundpool audio = Soundpool.fromOptions();
  static late int soundId;

  List <String> soundData = [
    "assets/audio/mixkit-correct-answer-tone-2870.wav",
    "assets/audio/mixkit-funny-fail-low-tone-2876.wav",
    "assets/audio/mixkit-page-turn-single-1104.wav",
    "assets/audio/mixkit-slow-sad-trombone-fail-472.wav",
  ];
}

void playChangePageSound() async {
  await sound.audio.release();
  sound.soundId = await rootBundle.load("assets/audio/mixkit-page-turn-single-1104.wav").then((ByteData soundData) {
    return sound.audio.load(soundData);
  });
  await sound.audio.play(sound.soundId);
}

void playCorrectSound() async {
  await sound.audio.release();
  sound.soundId = await rootBundle.load("assets/audio/mixkit-correct-answer-tone-2870.wav").then((ByteData soundData) {
    return sound.audio.load(soundData);
  });
  await sound.audio.play(sound.soundId);
}

void playWrongSound() async {
  await sound.audio.release();
  sound.soundId = await rootBundle.load("assets/audio/mixkit-funny-fail-low-tone-2876.wav").then((ByteData soundData) {
    return sound.audio.load(soundData);
  });
  await sound.audio.play(sound.soundId);
}

void playGameOverSound() async {
  await sound.audio.release();
  sound.soundId = await rootBundle.load("assets/audio/mixkit-slow-sad-trombone-fail-472.wav").then((ByteData soundData) {
    return sound.audio.load(soundData);
  });
  await sound.audio.play(sound.soundId);
}

void stopSound() async {
  await sound.audio.stop(sound.soundId);
  await sound.audio.release();
}