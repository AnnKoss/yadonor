typedef OnChoose = int Function(int i);

class QuizItem {
  final String questionText;
  final String answer1;
  final String answer2;
  final OnChoose onChoose;
  final String failText;

  QuizItem(
    this.questionText,
    this.answer1,
    this.answer2,
    this.onChoose,
    this.failText,
  );
}

const int NEXT = 9999;
const int FAIL = 9998;
const int SKIP = 9997;
// const int SUCCESS = 9997;

int firstAllow(int i) {
  if (i == 0) {
    return NEXT;
  } else {
    return FAIL;
  }
}

int secondAllow(int i) {
  if (i == 1) {
    return NEXT;
  } else {
    return FAIL;
  }
}

int skipPart(int i) {
  if (i == 1) {
    return SKIP;
  } else return NEXT;
}
