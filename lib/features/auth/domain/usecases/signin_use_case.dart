import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/common/param/sign_in_param.dart';
import 'package:spotify/core/config/usecase.dart';
import 'package:spotify/locator.dart';

import '../repository/auth_repositoty.dart';

class SignInUseCase implements UseCase<DataState,SignInParam> {

  @override
  Future<DataState<dynamic>> call({required SignInParam param}) {
    return locator<AuthRepository>().signIn(param);
  }
}