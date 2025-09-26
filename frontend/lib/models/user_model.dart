import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? username;
  final String? email;
  final String? password;

  const UserModel({this.uid = "", this.username, this.email, this.password});

  //this method get data in form of json and convert into dart object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json[
            '_id'], // _id,username,email and any other variable name  inside [' '] should be same as output json body of api
        username: json['username'],
        email: json['email']);
  }

  //by this method we going to save data into database in json form
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "uid": uid
    };
  }

  @override
  List<Object?> get props => [username, email, password, uid];
}
