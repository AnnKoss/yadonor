import 'package:flutter/material.dart';

void authenticationErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Text('Ошибка. Попробуйте ещё раз.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text('Закрыть'),
        )
      ],
    ),
  );
}
