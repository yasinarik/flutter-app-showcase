import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ) {
    username = '';
    password = '';
  }

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.username,
    required this.password,
  });

  late final String username;
  late final String password;

  LoginPresentationModel copyWith({
    String? username,
    String? password,
  }) {
    return LoginPresentationModel._(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {}
