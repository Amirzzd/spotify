import 'package:firebase_auth/firebase_auth.dart';

import 'data_state.dart';

class FirebaseCheckException {

  static Future<DataState> getError(FirebaseException e) async {
    print("error: " + e.toString());
    String message = '';
    switch (e.code){
      case 'weak-password' :
        message = 'The password is too weak';
        break;
      case 'email-already-in-use':
        message = 'An Account already exists with that email';
        break;
      case 'Invalid-email':
        message = 'No User found for that email';
        break;
      case 'The supplied auth credential is incorrect, malformed or has expired.':
        message = 'your password is wrong';
        break;
      case 'invalid-credential':
        message = 'Your Password is Wrong';
        break;
      case 'network-request-failed':
        message = 'check your connectiom';
        break;
      case 'too-many-requests':
        message = 'your access is denied try again later';
        break;
      case 'unknown':
        message = 'check your vpn';
        break;
      default: message = e.code;
    }
    return DataFailed(message);
  }
}