import 'package:flutter/material.dart';
import 'package:products/models/product/product.dart';
import 'package:products/models/product/product_manager.dart';
import 'package:provider/provider.dart';

import 'details_screen.dart';
import 'widgets/alert_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductManager>().products;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/images/${product.filename!}",
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
                              showMyDialog(product: product, context: context);
                            },
                            child: const Icon(Icons.edit,
                                size: 20, color: Colors.grey)),
                        const SizedBox(height: 10),
                        Text("R\$ ${product.price}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () {
            Product product = Product();
            showMyDialog(product: product, context: context);
          },
        ));
  }
}
