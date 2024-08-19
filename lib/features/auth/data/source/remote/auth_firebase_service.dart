import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/common/param/sign_in_param.dart';
import 'package:spotify/common/param/sign_up_param.dart';
import 'package:spotify/features/auth/data/models/usermodel.dart';

abstract class AuthFireBaseService {
  Future <dynamic> signUp(SignUpParam param);
  Future <dynamic> signIn(SignInParam param);
  Future <dynamic> getUser();
}

class AuthFirebaseServiceImpl extends AuthFireBaseService{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future signIn(SignInParam param) async{
    return await auth.signInWithEmailAndPassword(
        email: param.email,
        password: param.password,
    );
  }

  @override
  Future signUp(SignUpParam param) async {


    var data = await auth.createUserWithEmailAndPassword(
      email: param.email,
      password: param.password,
    );
    ///add to your collection
    await FirebaseFirestore.instance.collection('users').doc(data.user!.uid)
    .set({
      'name' : param.fullName,
      'email': param.email,
    });

    return data;
  }

  @override
  Future getUser() async{
    var user = await firebaseFirestore.collection('users').doc(
      auth.currentUser?.uid
    ).get();
    UserModel userModel = UserModel.fromJson(user.data()!);
    userModel.userImage = auth.currentUser?.photoURL ?? '';

    return(userModel);
  }
}