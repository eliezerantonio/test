import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String? id;
  String? title;
  String? type;
  String? description;
  String? filename;
  double? price;
 

//construtor
  Product(
      {this.title,
      this.type,
      this.description,
      this.filename,
     
      this.price,
    });
  //referencia firebase
  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('products').doc(id);


//converter docmentos em objectos
  Product.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    id = document.id;
    title = data['title'];
    type = data['type'];
    description = data['description'];
    filename = data['filename'];
  
    price = data['price'];



  }


  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    description = json['description'];
    filename = json['filename'];
  
    price = json['price'];
   
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['type'] = type;
    data['description'] = description;
    data['filename'] = filename;

    data['price'] = price;
  
    return data;
  }

  //metodos
  Future<void> save() async {
    loading = true;
    try {
      if (id == null) {
        final doc = await firestoreRef.set(toMap());
      } else {
       
        firestoreRef.update(toMap());
      }
    } catch (e) {
      print("Error $e");
    } finally {
      loading = false;
    }
  }

  void delete() {
    firestoreRef.delete();
  }

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
