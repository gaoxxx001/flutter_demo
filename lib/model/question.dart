typedef QuestionState = int;

sealed class Question {
  // 主状态
  static const int STATUS_INITIAL = 0;         // 初始状态
  static const int STATUS_WAITING_FOR_ANSWER = 1; // 等待回答状态
  static const int STATUS_INPUTTING = 2;       // 正在输入状态
  static const int STATUS_ANSWERED_CORRECT = 30; // 已回答 - 正确
  static const int STATUS_ANSWERED_INCORRECT = 31; // 已回答 - 错误

  QuestionState get state;

  void input(String text);

}

class SingleChoiceQuestion extends Question {
  List<String> options;
  String answer;
  String audioAssetPath;

  SingleChoiceQuestion({required this.options, required this.answer, required this.audioAssetPath});

  @override
  QuestionState state = Question.STATUS_INITIAL;

  @override
  void input(String text) {
    state = Question.STATUS_INPUTTING;
  }
}







