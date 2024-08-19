import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/core/config/usecase.dart';
import 'package:spotify/locator.dart';

import '../repository/auth_repositoty.dart';

class GetUserUseCase implements UseCase<DataState,dynamic> {

  @override
  Future<DataState<dynamic>> call({param}) {
    return locator<AuthRepository>().getUser();
  }
}