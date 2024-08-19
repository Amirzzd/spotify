import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/common/param/sign_up_param.dart';
import 'package:spotify/core/config/usecase.dart';
import 'package:spotify/features/auth/domain/repository/auth_repositoty.dart';
import 'package:spotify/locator.dart';

class SignUpUseCase extends UseCase<DataState,SignUpParam> {

  @override
  Future<DataState> call({required SignUpParam param}) {
    return locator<AuthRepository>().signUp(param);
  }
}