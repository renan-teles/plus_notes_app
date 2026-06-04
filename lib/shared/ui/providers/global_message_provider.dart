import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:plus_notes_app/shared/types/global_message_type_enum.dart';

class GlobalMessageProvider extends ChangeNotifier {
  String? message;
  MessageType? type;

  Timer? _timer;

  void show(String text, MessageType messageType) {
    if (message != null && type != null) {
      clear();
    }

    _timer?.cancel();

    message = text;
    type = messageType;

    notifyListeners();

    _timer = Timer(const Duration(seconds: 2), clear);
  }

  void clear() {
    message = null;
    type = null;

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
