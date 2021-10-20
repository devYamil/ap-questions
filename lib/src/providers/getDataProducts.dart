import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:AP/utils/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:AP/src/models/Products.dart';

class ProductServices {
  String _nextUrl = '';
  Future<List<Products>> getProducts({String url_custom = ''}) async {
    SharedPreferences sharedPreferences;
    List<Products> products = [];
    sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('token');

    if (_nextUrl == '') {
      _nextUrl = api_rest_uri + api_rest_get_products;
    }

    if (url_custom != '') {
      _nextUrl = url_custom;
    }

    if (_nextUrl != null) {
      print('********** $_nextUrl');
      final response = await http.get(_nextUrl, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        for (var pro in jsonData['data']) {
          Products product = Products.formJson(pro);
          products.add(product);
        }
        _nextUrl = jsonData['next_page_url'];
      } else {
        throw Exception('Failed to load get products');
      }
    }

    return products;
  }
}
