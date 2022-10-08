import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
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
    if (_model.isBusy) {
      return;
    }
    
    await (await usecaseLogin
            .execute(
              username: _model.username,
              password: _model.password,
            )
            .observeStatusChanges(
              (result) => emit(_model.copyWith(loginResult: result)),
            )
            .asyncFold(
              (fail) async => navigator.showError(fail.displayableFailure()),
              (success) async => navigator.showAlert(title: 'Success!', message: 'Welcome'),
            ) //
        );
  }
}
