import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:produtos/controller/product_controller.dart';
import 'package:produtos/controller/user_controller.dart';
import 'package:produtos/login_page.dart';
import 'package:produtos/product.dart';

import 'package:provider/provider.dart';

import 'alert_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductController>();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    String userLogado = firebaseAuth.currentUser!.email ?? "";
    return Scaffold(
        appBar: AppBar(
          title: Text(userLogado),
          actions: [
            IconButton(
              onPressed: () async {
                await firebaseAuth.signOut();
                products.products.clear();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        products.search = text;
                      },
                      decoration: const InputDecoration(
                          hintText: "Pesquisar", border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: products.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = products.filteredProducts[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                "assets/images/${product.filename!}.jpg",
                                fit: BoxFit.cover,
                                width: 100,
                                height: 200,
                              ),
                              title: Text(product.title!),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.description!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        showMyDialog(
                                            product: product, context: context);
                                      },
                                      child: const Icon(Icons.edit,
                                          size: 20, color: Colors.grey)),
                                  const SizedBox(height: 10),
                                  Text("KZ ${product.price}"),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Text(product.provider!),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.inputTime!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(" Qty: ${product.qty}"),
                                  Text("Expiry :${product.expiry}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, color: Colors.black),
          onPressed: () {
            Product product = Product();
            showMyDialog(product: product, context: context);
          },
        ));
  }
}
