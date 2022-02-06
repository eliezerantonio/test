import 'package:flutter/material.dart';
import 'package:products/models/product/product.dart';
import 'package:products/models/product/product_manager.dart';
import 'package:provider/provider.dart';

Future<void> showMyDialog(
    {Product? product, required BuildContext context}) async {
  final formState = GlobalKey<FormState>();
  void updateList() {
    context.read<ProductManager>().getProducts();
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
        value: product,
        child: AlertDialog(
          title: Row(
            children: [
              Text(product!.title ?? ""),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    product.delete();
                    updateList();
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.delete)),
            ],
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formState,
              child: ListBody(
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: product.title ?? "",
                    onSaved: (newValue) => product.title = newValue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Titulo"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome o titulo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.type ?? "",
                    onSaved: (newValue) => product.type = newValue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Tipo"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome o Tipo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.price.toString(),
                    onSaved: (newValue) =>
                        product.price = double.parse(newValue!),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome o preco';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Preco"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Salvar"),
              onPressed: () {
                if (!formState.currentState!.validate()) return;
                formState.currentState!.save();
                product.save();
                updateList();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
