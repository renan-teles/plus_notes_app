import 'package:flutter/material.dart';
import 'package:plus_notes_app/features/auth/presentation/widgets/auth_form_card_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const AuthFormCardWidget(isRegisterRole: false));
  }
}
