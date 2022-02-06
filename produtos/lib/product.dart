import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String? id;
  String? title;
  String? type;
  String? description;
  String? expiry;
  String? provider;
  String? filename;
  Timestamp? created;
  num? price;
  int? qty;
  String? inputTime;
  String? uid;

  Product(
      {this.title,
      this.type,
      this.description,
      this.filename,
      this.expiry,
      this.price,
      this.uid,
      this.qty,
      this.provider,
      this.inputTime,
      this.created});
  //referencia firebase
  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('products').doc(id);

  Product.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    id = document.id;
    title = data['title'];
    type = data['type'];
    description = data['description'];
    filename = data['filename'];
    uid = data['uid'];
    created = data["created"];
    expiry = data["expiry"];
    price = data['price'];
    provider = data['provider'];
    inputTime = data['inputTime'];
    qty = data['qty'];
  }
  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    description = json['description'];
    filename = json['filename'];
    uid = json['uid'];
    expiry = json['expiry'];
    created = json["created"];
    inputTime = json["inputTime"];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['type'] = type;
    data['description'] = description;
    data['filename'] = filename;
    data['expiry'] = expiry;
    data['uid'] = uid;
    data['provider'] = provider;
    data["created"] = Timestamp.now();
    data["inputTime"] = inputTime;
    data['price'] = price;
    data["qty"] = qty;
    return data;
  }

  //metodos
  Future<void> save() async {
    loading = true;
    try {
      if (id == null) {
        final doc = await firestoreRef.set(toMap());
      } else {
        print(Type);
        firestoreRef.update(toMap());
      }
    } catch (e) {
      print("Error $e");
    } finally {
      loading = false;
    }
  }

  void delete() async {
    await firestoreRef.delete();
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
