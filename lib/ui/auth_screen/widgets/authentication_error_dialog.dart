import 'package:flutter/material.dart';

void authenticationErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: const Text(
        'Ошибка. Попробуйте ещё раз.',
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Закрыть'),
        )
      ],
    ),
  );
}
