import 'package:flutter/material.dart';
import 'package:plus_notes_app/core/di/injection.dart';
import 'package:plus_notes_app/features/auth/presentation/pages/login_page.dart';
import 'package:plus_notes_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:plus_notes_app/features/notes/presentation/pages/notes_page.dart';
import 'package:plus_notes_app/features/notes/presentation/provider/notes_provider.dart';
import 'package:plus_notes_app/shared/ui/providers/global_message_provider.dart';
import 'package:plus_notes_app/shared/ui/widget/global_message.dart';
import 'package:provider/provider.dart';

void main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<NotesProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<GlobalMessageProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plus Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        ),
        home: _AppRouter(),
        builder: (context, child) {
          return Stack(children: [child!, const GlobalMessageOverlay()]);
        },
      ),
    );
  }
}

class _AppRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return switch (auth.status) {
      AuthStatus.authenticated => const NotesPage(),
      AuthStatus.unauthenticated => const LoginPage(),
    };
  }
}
