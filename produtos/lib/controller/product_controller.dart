import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:produtos/product.dart';

class ProductController with ChangeNotifier {
  ProductController() {
    // loadJsonData();
    getProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      String userLogado = firebaseAuth.currentUser!.uid;
    final QuerySnapshot snapshot = await firestore.collection("products").where("uid", isEqualTo: userLogado).get();

    products = snapshot.docs.map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;


    //pesquisa
  String _search = '';


  String get search => _search;
 

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(products);
    } else {
      filteredProducts.addAll(
        products
            .where((p) => p.title!.toLowerCase().contains(search.toLowerCase())),
      );
    }
    return filteredProducts;
  }
}
