typedef OnChoose = AnswerResult Function(int i);

enum AnswerResult {next, fail, skip}  

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


// const int NEXT = 9999;
// const int FAIL = 9998;
// const int SKIP = 9997;
// const int SUCCESS = 9996;

AnswerResult firstAllow(int i) {
  if (i == 0) {
    return AnswerResult.next;
  } else {
    return AnswerResult.fail;
  }
}

AnswerResult secondAllow(int i) {
  if (i == 1) {
    return AnswerResult.next;
  } else {
    return AnswerResult.fail;
  }
}

AnswerResult skipPart(int i) {
  if (i == 1) {
    return AnswerResult.skip;
  } else return AnswerResult.next;
}
