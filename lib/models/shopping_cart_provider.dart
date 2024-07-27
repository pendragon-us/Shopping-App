import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ShoppingCartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  List<dynamic> allProducts = [];
  List<dynamic> orderList = [];
  bool isFetching = true;
  double totalAmount = 0.0;
  int itemsInCart = 0;

  Future<void> getAllProducts() async {
    isFetching = true;
    notifyListeners();
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      allProducts = decodedData;
    } else {
      print("Failed to get products");
    }
    isFetching = false;
    notifyListeners();
  }

  Future<void> getOrderList() async {
    isFetching = true;
    notifyListeners();
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=5"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      orderList = decodedData;
    } else {
      print("Failed to get products");
    }
    isFetching = false;
    notifyListeners();
  }

  void addItemToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
    for (var item in _cartItems) {
      print(item['price']);
    }
    itemsInCart++;
    getTotalAmount();
    notifyListeners();
  }

  void getTotalAmount() {
    totalAmount = 0.0;
    for (var item in _cartItems) {
      totalAmount += double.parse(item['price']);
    }
    notifyListeners();
  }
}
