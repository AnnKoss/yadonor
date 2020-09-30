import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../models/quiz-item.dart';
import '../widgets/answer_option.dart';
import '../widgets/question_text.dart';

import '../screens/questionary_result_screen.dart';

class QuestionaryScreen extends StatefulWidget {
  static const routeName = '/questionary';

  @override
  _QuestionaryScreenState createState() => _QuestionaryScreenState();
}

class _QuestionaryScreenState extends State<QuestionaryScreen> {
  var questionIndex = 0;

  void onClick(int order) {
    AnswerResult result = questions[questionIndex].onChoose(order);
    if ((result == AnswerResult.next) &&
        (questionIndex < (questions.length - 1))) {
      setState(() {
        questionIndex++;
      });
    } else if (result == AnswerResult.fail) {
      Navigator.of(context).pushReplacementNamed(
        QuestionaryResultScreen.routeName,
        arguments: {
          'success': 'false',
          'failText': questions[questionIndex].failText,
        },
      );
      setState(() {
        questionIndex = 0;
      });
    } else if ((result == AnswerResult.next) &&
        (questionIndex == (questions.length - 1))) {
      Navigator.of(context).pushReplacementNamed(
        QuestionaryResultScreen.routeName,
        arguments: {
          'success': 'true',
          'failText': '',
        },
      );
      setState(() {
        questionIndex = 0;
      });
    } else if (result == AnswerResult.skip) {
      setState(() {
        questionIndex += 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff9fafc),
      appBar: AppBar(
        title: Text(
          'АНКЕТА ДОНОРА',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          BackButton(onPressed: () {
            (questionIndex > 0)
                ? setState(() {
                    questionIndex -= 1;
                  })
                : Navigator.of(context).pop();
          })
        ],
        // backgroundColor: Colors.white,
        // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      drawer: MainDrawer(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuestionText(questions[questionIndex].questionText),
            AnswerOption(questions[questionIndex].answer1, onClick, 0),
            AnswerOption(questions[questionIndex].answer2, onClick, 1),
          ],
        ),
      ),
    );
  }

  final List questions = [
    QuizItem(
      'Вам уже есть 18 лет?',
      'Да',
      'Нет',
      firstAllow,
      'Вы сможете стать донором после достижения совершеннолетия.',
    ),
    QuizItem(
      'Какого Вы пола?',
      'Ж',
      'М',
      skipPart,
      null,
    ),
    QuizItem(
      'С даты окончания Вашей менструации прошло более 5 дней?',
      'Да',
      'Нет',
      firstAllow,
      'Вы сможете стать донором через 5 дней после окончания менструации.',
    ),
    QuizItem(
      'Вы беременны или Вы женщина с ребенком в возрасте до 1 года?',
      'Да',
      'Нет',
      secondAllow,
      'Вы сможете стать донором через 1 год после родов.',
    ),
    QuizItem(
        'Сдавали ли Вы кровь последние 2 месяца?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором крови через 60 дней после предыдущей донации.'),
    QuizItem(
      'Вы принимали алкоголь в последние 48 часов?',
      'Да',
      'Нет',
      secondAllow,
      'Вы сможете стать донором через 48 часов после последнего принятия алкоголя.',
    ),
    QuizItem(
        'Вы недавно переболели гриппом, ангиной, ОРВИ?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 1 месяц после выздоровления.'),
    QuizItem(
        'Вы принимаете антибиотики в настоящий момент или недавно закончили их прием?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 1 месяц после завершения приёма антибиотиков.'),
    QuizItem(
        'Вы недавно перенесли аллергическое заболевание в стадии обострения?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 2 месяца после купирования острого периода.'),
    QuizItem(
        'Делали ли Вы пирсинг частей тела или прокалывание ушей, татуировки, полу-перманентный макияж либо акупунктуру в течение последнего года?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 1 год после окончания процедуры.'),
    QuizItem(
        'Проводились ли Вам процедуры переливания компонентов крови или ее препаратов за последние 6 месяцев?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 6 месяцев после совершения процедуры.'),
    QuizItem(
        'Были ли Вы в контакте с больными гепатитом, желтухой в течение последних 6 месяцев?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 6 месяцев с момента контакта с больными.'),
    QuizItem(
        'Вы ВИЧ-инфицированы или предполагаете, что Вы ВИЧ-инфицированы? \nПожалуйста, не сдавайте кровь, если Вы считаете, что необходимо пройти обследование на ВИЧ или гепатит или если у Вас был половой акт в прошлом году с кем-то, кто, по Вашему мнению, может быть ВИЧ-инфицирован или гепатит-положительным.',
        'Да',
        'Нет',
        secondAllow,
        'Если у Вас диагностирован ВИЧ, в целях обеспечения безопасности запасов крови, Вы не можете стать донором. \nЕсли Вы не уверены в том, что Вы в группе риска ВИЧ-инфекции, пожалуйста, проконсультируйтесь с Вашим лечащим врачом.Вы можете позвонить в ближайший Центр СПИД и задать любой волнующий Вас вопрос. \nМы понимаем, что Вы, возможно, будете разочарованы тем, что не сможете сдать кровь. Однако Служба крови надеется, что Вы поймете, нашу главную задачу - обеспечение максимальной безопасности компонентов донорской крови для пациентов.'),
    QuizItem(
        'Вы делали прививку живыми вакцинами или противостолбнячной сывороткой?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 1 месяц после проведения прививок.'),
    QuizItem(
        'Вы находились в заграничной командировке длительностью более 2 месяцев?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через полгода.'),
    QuizItem(
        'Вы находились более 3 месяцев в странах Азии, Африки, Южной и центральной Америки?',
        'Да',
        'Нет',
        secondAllow,
        'Вы сможете стать донором через 3 года.'),
  ];
}
