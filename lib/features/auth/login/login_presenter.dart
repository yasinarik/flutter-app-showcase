import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.usecaseLogin,
  );

  final LoginNavigator navigator;
  final LogInUseCase usecaseLogin;

  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void onChangedUsername({required String text}) {
    emit(_model.copyWith(username: text));
  }

  void onChangedPassword({required String text}) {
    emit(_model.copyWith(password: text));
  }

  Future<void> onTapLogin() async {
    final result = await usecaseLogin.execute(
      username: _model.username,
      password: _model.password,
    );
    log('result: $result');
  }
}
