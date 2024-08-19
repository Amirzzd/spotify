import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/common/error_handling/firebase_check_exception.dart';
import 'package:spotify/common/param/sign_in_param.dart';
import 'package:spotify/common/param/sign_up_param.dart';
import 'package:spotify/features/auth/data/source/remote/auth_firebase_service.dart';

import 'package:spotify/features/auth/domain/repository/auth_repositoty.dart';
import 'package:spotify/locator.dart';

class AuthRepositoryImpl extends AuthRepository{

  @override
  Future<DataState> signIn(SignInParam param) async{
    try {
      await locator<AuthFireBaseService>().signIn(param);
      return const DataSuccess('Sign In Was Successful');
    } on FirebaseException catch (e){
      return FirebaseCheckException.getError(e);
    }
  }

  @override
  Future<DataState> signUp(SignUpParam param) async {
    try {
      await locator<AuthFireBaseService>().signUp(param);
      return const DataSuccess('Sign Up Was Successful');
    } on FirebaseException catch (e){
      return FirebaseCheckException.getError(e);
    }
  }

  @override
  Future<DataState> getUser() async {
    try {
      var data = await locator<AuthFireBaseService>().getUser();
    return DataSuccess(data);
    } on FirebaseException catch (e){
    return FirebaseCheckException.getError(e);
    }
  }

}