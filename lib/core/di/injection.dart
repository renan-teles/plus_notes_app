import 'package:get_it/get_it.dart';
import 'package:plus_notes_app/core/database/plus_notes_database.dart';
import 'package:plus_notes_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:plus_notes_app/features/notes/domain/repository/note_repository.dart';
import 'package:plus_notes_app/features/auth/domain/repository/user_repository.dart';
import 'package:plus_notes_app/features/auth/domain/service/auth_service.dart';
import 'package:plus_notes_app/features/notes/domain/service/note_service.dart';
import 'package:plus_notes_app/features/notes/presentation/provider/notes_provider.dart';
import 'package:plus_notes_app/shared/ui/providers/global_message_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton(GlobalMessageProvider());
  getIt.registerSingleton(PlusNotesDatabase());

  getIt.registerLazySingleton(() => UserRepository(getIt<PlusNotesDatabase>()));
  getIt.registerLazySingleton(() => NoteRepository(getIt<PlusNotesDatabase>()));

  getIt.registerLazySingleton(() => AuthService(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => NoteService(getIt<NoteRepository>()));

  getIt.registerLazySingleton(() => AuthProvider(getIt<AuthService>()));
  getIt.registerLazySingleton(() => NotesProvider(getIt<NoteService>()));
}
