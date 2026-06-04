import 'package:flutter/material.dart';
import 'package:plus_notes_app/features/auth/presentation/widgets/auth_form_card_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const AuthFormCardWidget(isRegisterRole: true));
  }
}
