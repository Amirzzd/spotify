part of 'auth_bloc.dart';

abstract class SignUpStatus{}

class SignUpInitial extends SignUpStatus{}

class SignUpLoading extends SignUpStatus{}

class SignUpSuccess extends SignUpStatus{
  final String message;

  SignUpSuccess({required this.message});
}

class SignUpFailed extends SignUpStatus{
  final String message;

  SignUpFailed({required this.message});
}