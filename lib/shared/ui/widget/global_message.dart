import 'package:flutter/material.dart';
import 'package:plus_notes_app/shared/types/global_message_type_enum.dart';
import 'package:plus_notes_app/shared/ui/providers/global_message_provider.dart';
import 'package:provider/provider.dart';

class GlobalMessageOverlay extends StatelessWidget {
  const GlobalMessageOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<GlobalMessageProvider>();

    return Positioned(
      top: message.message != null ? 16 : -100,
      left: 16,
      right: 16,
      child: SafeArea(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: message.message != null ? 1 : 0,
          child: message.message == null
              ? const SizedBox.shrink()
              : GlobalMessage(message: message.message!, type: message.type!),
        ),
      ),
    );
  }
}

class GlobalMessage extends StatelessWidget {
  final String message;
  final MessageType type;

  const GlobalMessage({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case MessageType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;

      case MessageType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;

      case MessageType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
    }

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
            IconButton(
              onPressed: () {
                context.read<GlobalMessageProvider>().clear();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
