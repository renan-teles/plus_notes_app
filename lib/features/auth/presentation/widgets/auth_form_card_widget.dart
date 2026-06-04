import 'package:flutter/material.dart';
import 'package:plus_notes_app/features/auth/presentation/widgets/auth_form_widget.dart';

class AuthFormCardWidget extends StatelessWidget {
  final bool isRegisterRole;

  const AuthFormCardWidget({super.key, required this.isRegisterRole});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              color: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AuthFormWidget(isRegisterRole: isRegisterRole),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
