import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:plus_notes_app/features/auth/data/dto/sign_in_dto.dart';
import 'package:plus_notes_app/features/auth/data/dto/sign_up_dto.dart';
import 'package:plus_notes_app/features/auth/presentation/pages/register_page.dart';
import 'package:plus_notes_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:plus_notes_app/shared/types/global_message_type_enum.dart';
import 'package:plus_notes_app/shared/ui/providers/global_message_provider.dart';
import 'package:plus_notes_app/shared/utils/view_state_utils.dart';
import 'package:provider/provider.dart';

class AuthFormWidget extends StatefulWidget {
  final bool isRegisterRole;

  const AuthFormWidget({super.key, required this.isRegisterRole});

  @override
  State<StatefulWidget> createState() {
    return _AuthFormWidgetState();
  }
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isRegisterRole => widget.isRegisterRole;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    final bool loadingIs =
        isLoading(provider.signInState) || isLoading(provider.signUpState);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.note_add, size: 52, color: Colors.amber),

            const SizedBox(height: 16),

            Text(
              'Plus Notes',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text(
              isRegisterRole
                  ? 'Cadastre-se para continuar'
                  : 'Faça login para continuar',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            if (isRegisterRole) ...[
              TextFormField(
                controller: _usernameController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Nome de usuário obrigatório'),
                  MinLengthValidator(
                    3,
                    errorText:
                        'O nome de usuário deve conter no mínimo 3 caracteres',
                  ),
                ]).call,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2_outlined),
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],

            TextFormField(
              controller: _emailController,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Email obrigatório'),
                EmailValidator(errorText: 'Email inválido.'),
              ]).call,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Senha obrigatória'),
                MinLengthValidator(
                  5,
                  errorText: 'Senha deve conter no mínimo 5 caracteres.',
                ),
              ]).call,
              decoration: const InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),

            const Divider(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: loadingIs
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await _submit(context);
                      },
                      child: Text(isRegisterRole ? 'Registrar-se' : 'Entrar'),
                    ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                if (isRegisterRole) {
                  Navigator.pop(context);
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },

              child: Text(
                isRegisterRole
                    ? 'Já possui uma conta? Entrar'
                    : 'Não possui uma conta? Registrar-se',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (isRegisterRole) {
      await _signUp(context);
      return;
    }

    await _signIn(context);
  }

  Future<void> _signUp(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final messageProvider = context.read<GlobalMessageProvider>();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    final dto = SignUpDTO(name: username, email: email, password: password);
    await authProvider.signUp(dto);

    if (!context.mounted) return;

    if (isSuccess(authProvider.signUpState)) {
      Navigator.pop(context);
      messageProvider.show('Usuário criado com sucesso.', MessageType.success);
      return;
    }

    messageProvider.show(authProvider.errorMessage, MessageType.error);
  }

  Future<void> _signIn(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final messageProvider = context.read<GlobalMessageProvider>();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final dto = SignInDTO(email: email, password: password);
    await authProvider.signIn(dto);

    if (isSuccess(authProvider.signInState)) {
      return;
    }

    if (!context.mounted) return;
    messageProvider.show(authProvider.errorMessage, MessageType.error);
  }
}
