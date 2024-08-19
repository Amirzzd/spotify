part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpEvent extends AuthEvent{
  final SignUpParam signUpParam;

  SignUpEvent({required this.signUpParam});
}
class SignInEvent extends AuthEvent{
  final SignInParam signInParam;

  SignInEvent({required this.signInParam});
}

class ShowPassword extends AuthEvent{}

class GetUserEvent extends AuthEvent{}
