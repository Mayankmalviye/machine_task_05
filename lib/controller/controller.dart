
import 'dart:developer';
import 'package:flutter/material.dart';

import '../services/api_call.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User(this.id, this.email, this.firstName, this.lastName, this.avatar);
}

class UserProvider extends ChangeNotifier {
  bool loading = false;
  List dataList = [];
  //ApiService _apiService = ApiService();
  ApiService _apiService = ApiService();

  bool isLoading = false;

  getMyData() async {
    isLoading = true;
    final data = await _apiService.get();
    dataList = data['data'];
    log(dataList.toString());

    updateUserList(dataList);

    isLoading = false;
    notifyListeners();
  }

  List _userList = [];

  List<User> get userList => _userList
      .map((userMap) => User(
    userMap["id"] as int,
    userMap["email"] as String,
    userMap["first_name"] as String,
    userMap["last_name"] as String,
    userMap["avatar"] as String,
  ))
      .toList();

  void updateUserList(List newUserList) {
    _userList = newUserList;
    notifyListeners();
  }

  void editUserInfo(int userId, String newFirstName, String newLastName, String newEmail) {
    final userIndex = _userList.indexWhere((user) => user["id"] == userId);
    if (userIndex !=-1) {
      _userList[userIndex]["first_name"] = newFirstName;
      _userList[userIndex]["last_name"] = newLastName;
      _userList[userIndex]["email"] = newEmail;
      notifyListeners();
    }
  }

  void removeUser(int userId) {
    _userList.removeWhere((user) => user["id"] == userId);
    notifyListeners();
  }
}


// //import 'dart:ffi';
//
// import 'dart:ffi';
//
// import 'package:flutter/cupertino.dart';
//
// import '../services/api_call.dart';
//
// class User{
//   final int id ;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String avatar;
//
//   User(this.id,this.email,  this.firstName, this.lastName,  this.avatar);
// }
//
// class UserProvider extends ChangeNotifier{
//   List dataList = [];
//    ApiService _apiService = ApiService();
//   bool isloading =false;
//
//   getMydata()async{
//     isloading = true;
//     final data = await _apiService.get();
//     dataList = data['data'];
//     updateUserList(dataList);
//     notifyListeners();
//   }
//
//   List _userList =[];
//
//   List<User> get UserList => _userList
//       .map((userMap)=> User(
//     userMap['id']as int,
//     userMap['email']as String,
//     userMap['firstName']as String,
//     userMap['lastName']as String,
//     userMap['avatar']as String,
//   )
//   ).toList();
//
//   Void updateUserList(newUserList){
//     _userList = newUserList;
//     notifyListeners();
//   }
//
//   Void editUserInfo(int userId, String newFirstName,
//   String newLastName,
//   String newEmail){
//    final userIndex = _userList.indexWhere((element) => user["id"] == userId);
//    if(userIndex != -1){
//      _userList[userIndex]["first_name"]= newFirstName;
//      _userList[userIndex]["last_name"]= newLastName;
//      _userList[userIndex]["last"]= newEmail;
//     notifyListeners();
//    }
//   }
//
//   Void removeUser(int userId){
//     _userList.removeWhere((User) => User['id']== userId);
//     notifyListeners();
//   }
// }