import 'package:flutter/material.dart';

class DialogAlert extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool inverterConfirm;

  const DialogAlert({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText = 'Salvar',
    this.cancelText = 'Cancelar',
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.blueAccent,
    this.inverterConfirm = false,
  });

  Widget _getElevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: () {
        onConfirm();
        Navigator.pop(context);
      },
      child: Text(confirmText),
    );
  }

  Widget _getTextButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(cancelText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        if (inverterConfirm) ...[
          _getElevatedButton(context),
          _getTextButton(context),
        ] else ...[
          _getTextButton(context),
          _getElevatedButton(context),
        ],
      ],
    );
  }
}
