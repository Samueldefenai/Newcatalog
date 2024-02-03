import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:shared preferences/share preferences. dart';
import 'repository.dart';
import 'dart:convert';
import 'dart:io';

class NewsRepository extends Repository {
  final Dio _dio = Dio();
  
  future addNews(
    {required String title, 
    required String desc, 
    required String date, 
    required File image}) async {
      try {
        FormData formdata = Formdata.fromMap({
          'judul': title, 
          'desc': desc, 
          'date': date, 
          'gambar': 
            await MultipartFile.fromFile(image.path, filename: 'image.jpg')
        });
        
        Response response = await _dio.post(
          "https://clothcycle.000webhostapp.com/serverforclient/addnews.php", 
          data: formData);
          log(" Response add data :" + response.data);
          if (response.statusCode == 200){
            return response.data;
          } else {
            throw Exception('Failed to add news');
          }
      } catch (error) {
        log("Error $error");
      }
    } 
     
    Future getlistNews(String keyword) async {
      FormData formData = FormData.fromMap({
        'key': keyword, 
      });
      try {
        log("Ambil List");
        var response = await _dio.post(
          "https://clothcycle.000webhostapp.com/serverforclient/listnews.php",
          data: formData);
        log("list $response");
        
        if (response.statusCode == 200) {
          List newsList = response.data;
          return newsList;
        } else {
          log("Error" + response.statusCode.toString());
          return [];
        }
      } catch (error) {
        log("Error $error");
        return [];
      }
    }
    
    Future selectNews(String newsId) async {
      FormData formData = FormData.fromMap({
        'idnews': newsId, 
      });
      try {
        log("Select News");
        var response = await _dio.post(
          "https://clothcycle.000webhostapp.com/serverforclient/selectdata.php",
          data: formData);
        log("Select data $response");
        
        if (response.statusCode == 200) {
          List newsList = response.data;
          return newsList;
        } else {
          log("Error" + response.statusCode.toString());
          return [];
        }
      } catch (error) {
        log("Error $error");
        return [];
      }
    }
    
    Future deleteNews(String newsId) async {
      FormData formData = FormData.fromMap({
        'idnews': newsId, 
      });
      try {
        log("Delete News");
        var response = await _dio.post(
          "https://clothcycle.000webhostapp.com/serverforclient/deletenews.php",
          data: formData);
        log("Delete data $response");
        
        if (response.statusCode == 200) {
          Map newsList = response.data;
          return newsList;
        } else {
          log("Error" + response.statusCode.toString());
          return [];
        }
      } catch (error) {
        log("Error $error");
        return [];
      }
    }
  
    future editNews(
    {required String id, 
    required String title, 
    required String desc, 
    required String date, 
    File? image}) async {
      try {
        Map<String, dynamic> fromDataMap = {
          'idnews': id, 
          'judul': title, 
          'desc': desc, 
          'date': date, 
          };
          if (image != null){
            formDataMap['gambar'] = await MultipartFile.fromFile(image.path, filename: 'image.jpg');
          }
          FormData formData = FormData.fromMap(formDataMap);
        
        Response response = await _dio.post(
          "https://clothcycle.000webhostapp.com/serverforclient/editnews.php", 
          data: formData);
          log(" Response edit data :" + response.data);
          return response.data['status'];
          //if (response.statusCode == 200){
          //  return response.data;
          //} else {
          //  throw Exception('Failed to edit news');
          //}
      } catch (error) {
        log("Error $error");
      }
    }
  
}