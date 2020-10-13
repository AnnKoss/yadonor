import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:yadonor/widgets/main_drawer.dart';

class PrecautionsScreen extends StatelessWidget {
  static const routeName = '/precautions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ПРОТИВОПОКАЗАНИЯ К ДОНОРСТВУ',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Card(
              child: ExpansionTile(
                title: Text('Абсолютные противопоказания'),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                            fontSize: 18, height: 1.7, color: Colors.black),
                        children: <TextSpan>[
                          precautionSectionTitle(
                            '1.  Гемотрансмиссивные заболевания',
                            context,
                          ),
                          precautionTitle('''
\n1.1. Инфекционные: 
 \u2022 СПИД, носительство ВИЧ-инфекции
 \u2022 Сифилис, врожденный или приобретенный
 \u2022 Вирусные гепатиты, положительный результат исследования на маркеры вирусных гепатитов (HBsAg, анти-HCV антител)
 \u2022 Туберкулез, все формы
 \u2022 Бруцеллез
 \u2022 Сыпной тиф
 \u2022 Туляремия
 \u2022 Лепра
'1.2. Паразитарные: 
 \u2022 Эхинококкоз
 \u2022 Токсоплазмоз
 \u2022 Трипаносомоз
 \u2022 Филяриатоз
 \u2022 Ришта
 \u2022 Лейшманиоз

'''),
                          precautionSectionTitle(
                            '2.  Соматические заболевания',
                            context,
                          ),
                          precautionTitle('''
\n2.1. Злокачественные новообразования
2.2. Болезни крови
2.3. Органические заболевания ЦНС
2.4. Полное отсутствие слуха и речи
2.5. Психические заболевания
2.6. Наркомания, алкоголизм
2.7. Сердечно сосудистые заболевания:
 \u2022 гипертоническая болезнь II III ст.
 \u2022 ишемическая болезнь сердца
 \u2022 атеросклероз, атеросклеротический кардиосклероз
 \u2022 облитерирующий эндоартериит, неспецифический аортоартериит, рецидивирующий тромбофлебит
 \u2022 эндокардит, миокардит
 \u2022 порок сердца
2.8. Болезни органов дыхания:
 \u2022 бронхиальная астма
 \u2022 бронхоэктатическая болезнь, эмфизема легких, обструктивный бронхит, диффузный пневмосклероз в стадии декомпенсации
2.9. Болезни органов пищеварения:
 \u2022 ахилический гастрит
 \u2022 язвенная болезнь желудка и двенадцатиперстной кишки
2.10. Заболевания печени и желчных путей:
 \u2022 хронические заболевания печени, в том числе токсической природы и неясной этиологии
 \u2022 калькулезный холецистит с повторяющимися приступами и явлениями холангита
 \u2022 цирроз печени
2.11. Заболевания почек и мочевыводящих путей в стадии декомпенсации:
 \u2022 диффузные и очаговые поражения почек
 \u2022 мочекаменная болезнь
2.12. Диффузные заболевания соединительной ткани
2.13. Лучевая болезнь
2.14. Болезни эндокринной системы в случае выраженного нарушения функций и обмена веществ
2.15. Болезни ЛОР-органов:
 \u2022 озена
 \u2022 прочие острые и хронические тяжелые гнойно — воспалительные заболевания
2.16. Глазные болезни:
 \u2022 остаточные явления увеита (ирит, иридоциклит, хориоретинит)
 \u2022 высокая миопия (6 Д и более)
 \u2022 трахома
 \u2022 полная слепота
2.17. Кожные болезни:
 \u2022 распространенные заболевания кожи воспалительного и инфекционного характера
 \u2022 генерализованный псориаз, эритродермия, экземы, пиодермия, сикоз, красная волчанка, пузырчатые дерматозы
 \u2022 грибковые поражения кожи (микроспория, трихофития, фавус, эпидермофития) и внутренних органов (глубокие микозы)
 \u2022 гнойничковые заболевания кожи (пиодермия, фурункулез, сикоз)
2.18. Остеомиелит острый и хронический
2.19. Оперативные вмешательства по поводу резекции органа (желудок, почка, желчный пузырь, селезенка, яичники, матка и пр.) и трансплантации органов и тканей'''),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                title: Text('Временные противопоказания'),
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: '',
                      style: TextStyle(
                          fontSize: 18, height: 1.7, color: Colors.black),
                      children: <TextSpan>[
                        precautionSectionTitle(
                          '1. Факторы заражения гемотрансмиссивными заболеваниями',
                          context,
                        ),
                        precautionTitle(
                            '\nТрансфузии крови*, ее компонентов (исключение оставляют ожоговые реконвалесценты и лица, иммунизированные к резус - фактору)'),
                        precautionDuration(
                          '\n6 месяцев',
                          context,
                        ),
                        precautionTitle(
                          '\n\nОперативные вмешательства, в т.ч. аборты (необходимо представление медицинской справки) (выписки из истории болезни) о характере и дате операции',
                        ),
                        precautionDuration(
                          '\n6 месяцев со дня оперативного вмешательства',
                          context,
                        ),
                        precautionTitle(
                          '\n\nНанесение татуировки, пирсинг или лечение иглоукалыванием',
                        ),
                        precautionDuration(
                          '\n1 год с момента окончания процедур',
                          context,
                        ),
                        precautionTitle(
                          '\n\nПребывание в загранкомандировках длительностью более 2 месяцев',
                        ),
                        precautionDuration(
                          '\n6 месяцев',
                          context,
                        ),
                        precautionTitle(
                          '\n\nПребывание в эндемичных по малярии странах тропического и субтропического климата (Азия, Африка, Южная и Центральная Америка) более 3 месяцев',
                        ),
                        precautionDuration(
                          '\n3 года',
                          context,
                        ),
                        precautionTitle(
                          '''
\n\nКонтакт с больными гепатитами:
  \u2022 гепатит А''',
                        ),
                        precautionDuration(
                          '\n3 месяца',
                          context,
                        ),
                        precautionTitle(
                          '\n \u2022 гепатиты В и С',
                        ),
                        precautionDuration(
                          '\n1 год',
                          context,
                        ),
                        precautionSectionTitle(
                          '\n\n2.  Перенесенные заболевания',
                          context,
                        ),
                        precautionTitle(
                          '''
\n2.1. Инфекционные заболевания, не указанные в разделе «Абсолютные противопоказания»:
  \u2022 малярия в анамнезе при отсутствии симптомов и отрицательных результатов иммунологических тестов''',
                        ),
                        precautionDuration(
                          '\n3 года',
                          context,
                        ),
                        precautionTitle(
                          '\n \u2022 брюшной тиф после выздоровления и полного клинического обследования при отсутствии выраженных функциональных расстройств',
                        ),
                        precautionDuration(
                          '\n1 год',
                          context,
                        ),
                        precautionTitle(
                          '\n \u2022 ангина, грипп, ОРВИ',
                        ),
                        precautionDuration(
                          '\n1 месяц после выздоровления',
                          context,
                        ),
                        precautionTitle(
                          '\n\n2.2. Прочие инфекционные заболевания, не указанные в разделе «Абсолютные противопоказания» и п. 2.1 настоящего раздела',
                        ),
                        precautionDuration(
                          '\n6 месяцев после выздоровления',
                          context,
                        ),
                        precautionTitle(
                          '\n\n2.3. Экстракция зуба',
                        ),
                        precautionDuration(
                          '\n10 дней',
                          context,
                        ),
                        precautionTitle(
                          '\n2.4. Острые или хронические воспалительные процессы в стадии обострения независимо от локализации',
                        ),
                        precautionDuration(
                          '\n1 месяц после купирования острого периода',
                          context,
                        ),
                        precautionTitle(
                          '\n2.5. Вегето - сосудистая дистония',
                        ),
                        precautionDuration(
                          '\n1 месяц',
                          context,
                        ),
                        precautionTitle(
                          '\n2.6. Аллергические заболевания в стадии обострения',
                        ),
                        precautionDuration(
                          '\n2 месяца после купирования острого периода',
                          context,
                        ),
                        precautionSectionTitle(
                          '\n\n3. Период беременности и лактации',
                          context,
                        ),
                        precautionDuration(
                          '\n1 год после родов, 3 месяца после окончания лактации',
                          context,
                        ),
                        precautionSectionTitle(
                          '\n\n4. Период менструации',
                          context,
                        ),
                        precautionDuration(
                          '\n5 дней со дня окончания менструации',
                          context,
                        ),
                        precautionSectionTitle(
                          '\n\n5. Прививки',
                          context,
                        ),
                        precautionTitle(
                          '\n \u2022 прививка убитыми вакцинами (гепатит В, столбняк, дифтерия, коклюш, паратиф, холера, грипп), анатоксинами',
                        ),
                        precautionDuration(
                          '\n10 дней',
                          context,
                        ),
                        precautionTitle(
                          '\n \u2022 прививка живыми вакцинами (бруцеллез, чума, туляремия, вакцина БЦЖ, оспа, краснуха, полиомиелит перорально), введение противостолбнячной сыворотки (при отсутствии выраженных воспалительных явлений на месте инъекции)',
                        ),
                        precautionDuration(
                          '\n1 месяц',
                          context,
                        ),
                        precautionTitle(
                          '\n \u2022 введение иммуноглобулина против гепатита В',
                        ),
                        precautionDuration(
                          '\n1 год',
                          context,
                        ),
                        precautionTitle(
                          '\nпрививка вакциной против бешенства',
                        ),
                        precautionDuration(
                          '\n2 недели',
                          context,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextSpan precautionSectionTitle(String text, BuildContext context) {
  return TextSpan(
    text: text,
    style: TextStyle(
        color: Theme.of(context).primaryColor, fontSize: 20, height: 1.2),
  );
}

TextSpan precautionTitle(String text) {
  return TextSpan(
    text: text,
  );
}

TextSpan precautionDuration(String text, BuildContext context) {
  return TextSpan(
    text: text,
    style: TextStyle(color: Theme.of(context).primaryColor),
  );
}
