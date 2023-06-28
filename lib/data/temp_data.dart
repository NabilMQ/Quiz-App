mixin TempData {
  static int? addScore;
  static int? subScore;
  static int? mulScore;
  static int? divScore;
  static int? mixScore;
}

void initScore() {
  TempData.addScore = 0;
  TempData.subScore = 0;
  TempData.mulScore = 0;
  TempData.divScore = 0;
  TempData.mixScore = 0;
}