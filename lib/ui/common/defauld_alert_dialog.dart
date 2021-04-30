import 'package:flutter/material.dart';

import 'package:yadonor/ui/common/button.dart';

class DefaultAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Что-то пошло не так...',
      ),
      actions: [
        Button(
          context: context,
          onPressed: () => Navigator.of(context).pop(),
          buttonText: 'Назад',
        )
      ],
    );
  }
}
