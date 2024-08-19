
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/common/param/sign_in_param.dart';
import 'package:spotify/common/param/sign_up_param.dart';
import 'package:spotify/features/auth/domain/entities/user_entity.dart';
import 'package:spotify/features/auth/domain/usecases/get_user_use_case.dart';
import 'package:spotify/features/auth/domain/usecases/signin_use_case.dart';
import 'package:spotify/features/auth/domain/usecases/signup_use_case.dart';
import 'package:spotify/locator.dart';


part 'auth_state.dart';
part 'signin_status.dart';
part 'signup_status.dart';
part 'auth_event.dart';
part 'get_user_status.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(
    signInStatus: SignInInitial(),
    signUpStatus: SignUpInitial(),
    getUserStatus: GetUserStatusLoading(),
    togglePass: true,
  )) {
    on<AuthEvent>((event, emit) async{

      ///--- sign up
      if(event is SignUpEvent){
        emit(state.copyWith(newSignUpStatus: SignUpLoading()));
        DataState dataState = await locator<SignUpUseCase>().call(param: event.signUpParam);
        dataState is DataSuccess
            ? emit(state.copyWith(newSignUpStatus: SignUpSuccess(message: dataState.data.toString())))
            : emit(state.copyWith(newSignUpStatus: SignUpFailed(message: dataState.message!)));
       }

      ///--- sign in
      if(event is SignInEvent){
        emit(state.copyWith(newSignInStatus: SignInLoading()));
        DataState dataState = await locator<SignInUseCase>().call(param: event.signInParam);
        dataState is DataSuccess
            ? emit(state.copyWith(newSignInStatus: SignInSuccess(message: dataState.data.toString())))
            : emit(state.copyWith(newSignInStatus: SignInFailed(message: dataState.message!)));
        }

      ///--- toggle
      if(event is ShowPassword){
        emit(state.copyWith(newTogglePass: !state.togglePass));
       }

      ///--- user
      if(event is GetUserEvent){
        DataState dataState = await locator<GetUserUseCase>().call();
        dataState is DataSuccess
            ? emit(state.copyWith(newGetUserStatus: GetUserStatusSuccess(userEntity: dataState.data)))
            : emit(state.copyWith(newGetUserStatus: GetUserStatusFailed(message: dataState.message!)));
      }
     },
    );
  }
}
