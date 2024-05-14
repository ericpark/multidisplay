import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/auth/auth.dart';

part 'auth_state.dart';
part 'generated/auth_cubit.freezed.dart';
part 'generated/auth_cubit.g.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState());

  final AuthRepository _authRepository;

  /// Initialize the auth repository and log in user if already exists
  Future<void> init() async {
    // checks if user was previously logged in
    if (_authRepository.isLoggedIn) {
      // if get the user info from firebase and then emit user
      final user = User.fromJson(
        (await _authRepository.getUserById(
          id: _authRepository.currentUser.id,
        ))!
            .toJson(),
      );
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
    }
  }

  Future<String?> login({
    required String emailAddress,
    required String password,
  }) async {
    final user = await _authRepository.loginWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (user == null) {
      return 'Incorrect email or password';
    }
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        user: User.fromJson(user.toJson()),
      ),
    );
    return null;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }

  // Removed Hydrated Cubit to let repository handle the current user.
  /*
  @override
  AuthState fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthState state) => state.toJson();*/
}
