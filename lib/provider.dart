// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/model.dart';

class AuthProvider with ChangeNotifier {
  String? _signupToken;
  String? _loginToken;

  // Getter methods to access the tokens
  String? get signupToken => _signupToken;
  String? get loginToken => _loginToken;

  List<ProductListModel> _products = [];
  List<ProductListModel> get products => _products;

  // Function to handle signup
  Future<void> signup(
      String name, String email, String mobile, String password) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/Register.php');
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['mobile'] = mobile;
      request.fields['password'] = password;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var result = json.decode(responseBody);

      if (response.statusCode == 200 && result['data']['user_token'] != null) {
        // Store signup token
        _signupToken = result['data']['user_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('signupToken', _signupToken!);

        // Show success message
        await Future.delayed(const Duration(seconds: 5));
      } else {
        throw Exception(result['message']);
      }
    } catch (error) {
      throw Exception('Signup failed: $error');
    }

    notifyListeners();
  }

  // Function to handle login
  Future<void> login(String email, String password) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/Login.php');
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['email'] = email;
      request.fields['password'] = password;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var result = json.decode(responseBody);

      if (response.statusCode == 200 && result['data']['user_token'] != null) {
        // Store login token (overwriting signup token)
        _loginToken = result['data']['user_token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loginToken', _loginToken!);

        // Clear signup token if needed
        await prefs.remove('signupToken');
      } else {
        throw Exception(result['message']);
      }
    } catch (error) {
      throw Exception('Login failed: $error');
    }

    notifyListeners();
  }

  // // Fetch product list
  // Future<void> fetchProductList() async {
  //   final url =
  //       Uri.parse('https://shareittofriends.com/demo/flutter/productList.php');
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('loginToken');

  //     var request = http.MultipartRequest('POST', url);
  //     request.fields['user_login_token'] =
  //         token ?? ''; // Ensure the token is passed in the request

  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //     if (response.statusCode == 200) {
  //       List<ProductListModel> fetchedProductList =
  //           productListModelFromJson(responseBody);
  //       _productList = fetchedProductList;
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to fetch product list');
  //     }
  //   } catch (error) {
  //     throw Exception('Error fetching product list: $error');
  //   }
  // }

  // Function to clear all tokens on logout
  Future<void> logout() async {
    _signupToken = null;
    _loginToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('signupToken');
    await prefs.remove('loginToken');
    notifyListeners();
  }

  // Load tokens when the app starts
  Future<void> loadTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _signupToken = prefs.getString('signupToken');
    _loginToken = prefs.getString('loginToken');
    notifyListeners();
  }

  // Future<void> fetchProductList() async {
  //   if (_loginToken == null) {
  //     throw Exception('Login token is missing');
  //   }

  //   final url =
  //       Uri.parse('https://shareittofriends.com/demo/flutter/productList.php');
  //   try {
  //     var request = http.MultipartRequest('POST', url);
  //     request.fields['user_login_token'] = _loginToken!;

  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //     var result = json.decode(responseBody);

  //     if (response.statusCode == 200) {
  //       _products = productListModelFromJson(responseBody);
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to load products');
  //     }
  //   } catch (error) {
  //     throw Exception('Error fetching product list: $error');
  //   }
  // }

  // Future<void> addProduct(String id, String name, String moq, String price,
  //     String discountedPrice) async {
  //   if (_loginToken == null) {
  //     throw Exception('Login token is missing');
  //   }

  //   final url =
  //       Uri.parse('https://shareittofriends.com/demo/flutter/productList.php');
  //   try {
  //     var request = http.MultipartRequest('POST', url);
  //     request.fields['user_login_token'] = _loginToken!;
  //     request.fields['id'] = id;
  //     request.fields['name'] = name;
  //     request.fields['moq'] = moq;
  //     request.fields['price'] = price;
  //     request.fields['discounted_price'] = discountedPrice;

  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //     var result = json.decode(responseBody);

  //     if (response.statusCode == 200) {
  //       _products
  //           .add(ProductListModel.fromJson(result)); // Add product to the list
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to add product');
  //     }
  //   } catch (error) {
  //     throw Exception('Error adding product: $error');
  //   }
  // }

  // Add this method to send product data
  Future<void> addProduct(
      String name, String moq, String price, String discountPrice) async {
    final url =
        Uri.parse('https://shareittofriends.com/demo/flutter/addProduct.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loginToken = prefs.getString('loginToken');

    if (_loginToken == null) {
      throw Exception('User is not logged in.');
    }

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['user_login_token'] = _loginToken!;
      request.fields['name'] = name;
      request.fields['moq'] = moq;
      request.fields['price'] = price;
      request.fields['discount_price'] = discountPrice;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var result = json.decode(responseBody);

      if (response.statusCode == 200 && result['title'] == "Success!") {
        notifyListeners(); // Notify UI if required
        return;
      } else {
        throw Exception(result['message']);
      }
    } catch (error) {
      throw Exception('Failed to add product: $error');
    }
  }
}
