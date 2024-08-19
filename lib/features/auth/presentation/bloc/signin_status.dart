part of 'auth_bloc.dart';

abstract class SignInStatus{}

class SignInInitial extends SignInStatus{}

class SignInLoading extends SignInStatus{}

class SignInSuccess extends SignInStatus{
  final String message;

  SignInSuccess({required this.message});
}

class SignInFailed extends SignInStatus{
  final String message;

  SignInFailed({required this.message});
}