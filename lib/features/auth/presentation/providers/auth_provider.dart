import 'package:flutter/foundation.dart';
import 'package:plus_notes_app/features/auth/data/dto/sign_in_dto.dart';
import 'package:plus_notes_app/features/auth/data/dto/sign_up_dto.dart';
import 'package:plus_notes_app/features/auth/domain/model/user_model.dart';
import 'package:plus_notes_app/features/auth/domain/service/auth_service.dart';
import 'package:plus_notes_app/shared/types/view_state_enum.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final AuthService _service;

  UserModel? currentUser;

  AuthStatus status = AuthStatus.unauthenticated;

  ViewState signInState = ViewState.idle;
  ViewState signUpState = ViewState.idle;

  String errorMessage = '';

  AuthProvider(this._service);

  Future<void> signIn(SignInDTO dto) async {
    signInState = ViewState.loading;
    errorMessage = '';

    notifyListeners();

    try {
      currentUser = await _service.signIn(dto);
      signInState = ViewState.success;
      status = AuthStatus.authenticated;
    } catch (e) {
      status = AuthStatus.unauthenticated;
      signInState = ViewState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> signUp(SignUpDTO dto) async {
    signUpState = ViewState.loading;
    errorMessage = '';

    notifyListeners();

    try {
      await _service.signUp(dto);
      signUpState = ViewState.success;
    } catch (e) {
      signUpState = ViewState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  void logout() {
    status = AuthStatus.unauthenticated;
    currentUser = null;
    notifyListeners();
  }
}
