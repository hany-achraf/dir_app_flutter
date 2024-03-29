import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/services/auth.dart';

class CategoriesProvider extends ChangeNotifier {
  final Auth auth;
  CategoriesProvider({@required this.auth});

  List<Category> _categories = null;
  List<Category> get categories => _categories;

  bool gotNextPage = false;
  int currentPageNumber = 1;

  void loadInitialCategories() async {
    if (_categories != null) {
      _categories = null;
      currentPageNumber = 1;
    }

    var response = await http.get(
      Uri.parse('$api/categories'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${auth.token}',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      gotNextPage = responseJson['next_page_url'] != null ? true : false;
      _categories = [];
      List categoriesJson = responseJson['data'];
      categoriesJson.forEach((categoryJson) {
        _categories.add(Category.fromJson(categoryJson));
      });
    }

    notifyListeners();
  }

  Future<bool> loadMoreCategories() async {
    if (!gotNextPage) return false;

    var response = await http.get(
      Uri.parse('$api/categories?page=${++currentPageNumber}'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${auth.token}',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      gotNextPage = responseJson['next_page_url'] != null ? true : false;
      List categoriesJson = responseJson['data'];
      categoriesJson.forEach((categoryJson) {
        _categories.add(Category.fromJson(categoryJson));
      });
      notifyListeners();
    }

    return gotNextPage;
  }
}
