typedef OnChoose = AnswerResult Function(int i);

enum AnswerResult {next, fail, skip}  

///Single question info item in donor questionnaire questionary_screen.dart. 
///Holds the text of the question [questionText] and possible answers [answer1], [answer2], 
///function [onChoose] that decides whether to pass to the next question or finish and show [failText].
///Success result is managed separately.
class QuestionaryItem {
  final String questionText;
  final String answer1;
  final String answer2;
  final OnChoose onChoose;
  final String failText;

  QuestionaryItem(
    this.questionText,
    this.answer1,
    this.answer2,
    this.onChoose,
    this.failText,
  );
}

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
