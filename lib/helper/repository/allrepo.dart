

import 'dart:convert';

import 'package:edukit/model/address.dart';
import 'package:edukit/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Address> getAddress(String pinCode) async {
  Address address = Address();
  try {

    final response = await http.get(Uri.parse(AppConstants.getAddress + pinCode));
    if (response.statusCode == 200) {
      print(json.decode(response.body)[0]);
      address = Address.fromJson(json.decode(response.body)[0]);
      return address;
    } else {
      return address;
    }
  } catch (e) {
    return address;
  }

}

Future<bool> signUpProcess(String name, String email, String password, String myAddress) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  try{
    sharedPreferences.setString(AppConstants.sPName, name);
    sharedPreferences.setString(AppConstants.sPEmail, email);
    sharedPreferences.setString(AppConstants.sPAddress, myAddress);
    sharedPreferences.setString(AppConstants.sPPassword, password);
    return true;
  }catch(e){
    return false;
  }
}

Future<bool> logOut() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  try{
    sharedPreferences.clear();
    return true;
  }catch(e){
    return false;
  }
}

Future<String> loginProcess(String email, String password) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String sEmail = sharedPreferences.getString(AppConstants.sPEmail) ?? "";
  String sPassword = sharedPreferences.getString(AppConstants.sPPassword) ?? "";
  if(sEmail == email){
    if(sPassword == password){
      sharedPreferences.setBool(AppConstants.sPLogin, true);
      return "Success";
    }else{
      return "Wrong Password";
    }
  }else{
    return "Wrong Email";
  }

}

Future<bool> editProfile(String name, String email, String password, String myAddress) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  try{
    sharedPreferences.setString(AppConstants.sPName, name);
    sharedPreferences.setString(AppConstants.sPEmail, email);
    sharedPreferences.setString(AppConstants.sPAddress, myAddress);
    sharedPreferences.setString(AppConstants.sPPassword, password);
    return true;
  }catch(e){
    return false;
  }
}
