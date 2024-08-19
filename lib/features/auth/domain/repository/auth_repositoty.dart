import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/common/param/sign_in_param.dart';
import 'package:spotify/common/param/sign_up_param.dart';

abstract class AuthRepository{
  Future <DataState<dynamic>> signUp(SignUpParam param);
  Future <DataState<dynamic>> signIn(SignInParam param);
  Future <DataState<dynamic>> getUser();
}