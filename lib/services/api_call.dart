import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;

class ApiService{
  String baseurl = "https://reqres.in/api/users?page=1";

  Future<Map<String,dynamic>> get() async{
 try{
   final response = await http.get(Uri.parse(baseurl));
   if(response.statusCode==200){
     final jsonData = json.decode(response.body);
     return jsonData;
   }else{
     log('error: $response.statusCode');
     throw('error: $response.statusCode');
   }
 }catch(e){
   log(e.toString());
   return {
     "status":false,
     "message": "api is not valid"
   };
  }
}}