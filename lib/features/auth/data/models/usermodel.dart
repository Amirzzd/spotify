import 'package:spotify/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

  UserModel({
    super.fullName,
    super.email,
    super.userImage
});

  factory UserModel.fromJson(Map <String,dynamic> json){
    return UserModel(
      fullName: json['name'],
      email: json['email'],
    );
  }
}