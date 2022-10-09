import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/auth_mock_definitions.dart';
import '../mocks/auth_mocks.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;
  late LogInUseCase usecaseLogin;

  test(
    'Must SUCCEED if usecaseLogin SUCCEEDS',
    () async {
      // GIVEN
      when(
        () => presenter.usecaseLogin.execute(
          username: any(named: 'username'), // test
          password: any(named: 'password'), // test123
        ),
      ).thenAnswer((_) => successFuture(const User.anonymous()));

      when(
        () => navigator.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
        ),
      ).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onTapLogin();

      // THEN
      verify(
        () => navigator.showAlert(
          title: any(named: 'title'),
          message: any(named: 'message'),
        ),
      );
    },
  );

  test(
    // TODO: Is there a way to make this test pass when usecaseLogin FAILS?
    'Must FAIL if usecaseLogin FAILS',
    () async {
      // GIVEN
      when(
        () => presenter.usecaseLogin.execute(
          username: 'wrong',
          password: 'wrong',
        ),
      ).thenAnswer((_) => failFuture(const LogInFailure.unknown()));

      when(
        () => navigator.showError(
          any(),
        ),
      ).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onTapLogin();

      // THEN
      verify(
        () => navigator.showError(
          any(),
        ),
      );
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial(
      const LoginInitialParams(),
    );

    navigator = MockLoginNavigator();
    usecaseLogin = AuthMocks.logInUseCase;

    presenter = LoginPresenter(
      model,
      navigator,
      usecaseLogin,
    );
  });
}
