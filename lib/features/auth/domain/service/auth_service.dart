import 'package:bcrypt/bcrypt.dart';
import 'package:plus_notes_app/features/auth/data/dto/sign_in_dto.dart';
import 'package:plus_notes_app/features/auth/data/dto/sign_up_dto.dart';
import 'package:plus_notes_app/features/auth/domain/exception/invalid_credentials_exception.dart';
import 'package:plus_notes_app/core/exception/resource_already_exists_exception.dart';
import 'package:plus_notes_app/core/exception/resource_not_found_exception.dart';
import 'package:plus_notes_app/features/auth/domain/model/user_model.dart';
import 'package:plus_notes_app/features/auth/domain/repository/user_repository.dart';

class AuthService {
  final UserRepository _repository;

  AuthService(this._repository);

  Future<void> signUp(SignUpDTO dto) async {
    final exists = await _repository.existsByEmail(dto.email);

    if (exists) {
      throw ResourceAlreadyExistsException(message: 'Usuário já cadastrado.');
    }

    final hash = BCrypt.hashpw(dto.password, BCrypt.gensalt());

    final user = UserModel(
      name: dto.name,
      email: dto.email,
      passwordHash: hash,
      createdAt: DateTime.now(),
    );

    await _repository.create(user);
  }

  Future<UserModel> signIn(SignInDTO dto) async {
    final UserModel? user = await _repository.findByEmail(dto.email);

    if (user == null) {
      throw ResourceNotFoundException(message: 'Usuário não encontrado.');
    }

    if (!BCrypt.checkpw(dto.password, user.passwordHash)) {
      throw InvalidCredentialsException();
    }

    return user;
  }
}
