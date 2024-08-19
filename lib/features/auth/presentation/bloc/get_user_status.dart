part of 'auth_bloc.dart';


abstract class GetUserStatus{}

class GetUserStatusInitial extends GetUserStatus{}

class GetUserStatusLoading extends GetUserStatus{}

class GetUserStatusSuccess extends GetUserStatus{
  final UserEntity userEntity;

  GetUserStatusSuccess({required this.userEntity});
}

class GetUserStatusFailed extends GetUserStatus{
  final String message;

  GetUserStatusFailed({required this.message});
}