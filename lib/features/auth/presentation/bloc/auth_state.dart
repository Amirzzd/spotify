part of 'auth_bloc.dart';

class AuthState {
  SignUpStatus signUpStatus;
  SignInStatus signInStatus;
  GetUserStatus getUserStatus;
  bool togglePass;
  AuthState({
    required this.togglePass,
    required this.signUpStatus,
    required this.signInStatus,
    required this.getUserStatus
});
  AuthState copyWith ({
    SignUpStatus ? newSignUpStatus,
    SignInStatus ? newSignInStatus,
    GetUserStatus? newGetUserStatus,
    bool? newTogglePass
  }){
  return AuthState(
    signInStatus: newSignInStatus ?? signInStatus,
    signUpStatus: newSignUpStatus ?? signUpStatus,
    togglePass: newTogglePass ?? togglePass,
    getUserStatus: newGetUserStatus ?? getUserStatus
   );
  }
}


