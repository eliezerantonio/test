import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:products/models/product/product.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';

class ProductManager with ChangeNotifier {
  ProductManager() {
    // loadJsonData();
    getProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  List<Product> products = [];

//metodo para processar o ficheiro json e salvar no firebase
  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/products.json');
    List data = json.decode(jsonText);

    List<Product> products =
        data.map<Product>((map) => Product.fromJson(map)).toList();

    for (var i = 0; i < products.length; i++) {
      products[i].save();
    }
  }

  //metodo para busca produtos no firebase

  Future<void> getProducts() async {
    final QuerySnapshot snapshot = await firestore.collection("products").get();

    products = snapshot.docs.map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;
}
