// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => presenter.onChangedUsername(text: text),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => presenter.onChangedPassword(text: text),
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.areFieldsFilled ? presenter.onTapLogin : null,
                    child: buildButtonChild(),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget buildButtonChild() {
    late Widget buttonChild;
    // ignore: prefer-conditional-expressions
    if (state.isBusy) {
      buttonChild = const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    } else {
      buttonChild = Text(appLocalizations.logInAction);
    }
    return Center(
      child: buttonChild,
    );
  }
}
