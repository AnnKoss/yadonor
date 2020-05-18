import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/build_shadow_container.dart';

import '../widgets/main_drawer.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  TextSpan(
                      text:
                          'Стать донором может практически любой здоровый человек, если он старше 18 лет, не имеет противопоказаний к донорству, а его вес больше 50 кг.'),
                  TextSpan(
                      text:
                          '\n\nС другой стороны, стать донором крови и ее компонентов может только Человек с большой буквы. Человек, который готов встать пораньше, '),
                  TextSpan(
                    text: 'потратить свое время, чтобы спасти чью-то жизнь.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    style: Theme.of(context).textTheme.subhead,
                    text: '\n\n\nПРОТИВОПОКАЗАНИЯ',
                  ),
                  TextSpan(
                      text:
                          '\nПеред процедурой потенциальный донор проходит бесплатное медицинское обследование, которое включает в себя приема врачом-трансфузиологом и предварительное лабораторное исследование.'),
                  TextSpan(
                      text:
                          '\n\nПри этом есть ряд противопоказаний к донорству: абсолютных, то есть независящих от давности заболевания и результатов лечения, и временных — действующих лишь определенный срок.'),
                  TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                      text: '\n\nАбсолютными'),
                  TextSpan(
                      text:
                          ' противопоказаниями является наличие таких серьезных заболеваний как ВИЧ-инфекция, сифилис, вирусные гепатиты, туберкулез, болезни крови, онкологические заболевания и другие.'),
                ],
              ),
            ),
            buildShadowContainer(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            'Возможно, Вы будете разочарованы тем, что не сможете совершить донацию при наличии абсолютных противопоказаний.\nОднако Служба крови надеется, что Вы поймете нашу главную задачу — обеспечение безопасности компонентов донорской крови для пациентов.'),
                    TextSpan(
                        text:
                            '\n\nНаличие противопоказаний к донорству не означает, что Вы не можете внести свой вклад в развитие добровольного донорства крови!'),
                    //+ vuolonteers text
                  ],
                ),
              ),
            ),
            RichText(
              text:
                  TextSpan(style: Theme.of(context).textTheme.body1, children: [
                TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'Временные'),
                TextSpan(
                    text:
                        ' противопоказания имеют различные сроки в зависимости от причины. Самыми распространенными запретами являются: удаление зуба (10 дней), нанесение татуировки, пирсинг или лечение иглоукалыванием (1 год), ангина, грипп, ОРВИ (1 месяц с момента выздоровления), менструация (5 дней со дня окончания), аборт (6 месяцев), период беременности и лактации (1 год после родов, 3 месяца после окончания лактации), прививки.'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
