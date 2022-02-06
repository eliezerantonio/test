import 'package:flutter/material.dart';
import 'package:produtos/controller/product_controller.dart';
import 'package:produtos/product.dart';

import 'package:provider/provider.dart';

Future<void> showMyDialog(
    {Product? product, required BuildContext context}) async {
  final formState = GlobalKey<FormState>();
  void updateList() {
    context.read<ProductController>().getProducts();
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
                    initialValue: product.description ?? "",
                    onSaved: (newValue) => product.description = newValue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Descricao"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome o descricao';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.filename ?? "",
                    onSaved: (newValue) => product.filename = newValue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Filename"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome o Filename';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.inputTime ?? "",
                    onSaved: (newValue) => product.inputTime = newValue,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Data entrada"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome a data de entrada';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.expiry ?? "",
                    onSaved: (newValue) => product.expiry = newValue,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Data Caducidade"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome a Data Caducidade';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.provider ?? "",
                    onSaved: (newValue) => product.provider = newValue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Forecidor"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome a data de entrada';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: product.price == null
                        ? "0.0"
                        : product.price.toString(),
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
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue:
                        product.qty == null ? "0" : product.qty.toString(),
                    onSaved: (newValue) => product.qty = int.parse(newValue!),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Infome a quantidade';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Quatidade"),
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
