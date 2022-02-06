// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();


  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Column(
        children: [

          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: "E-mail"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await auth
                  .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Sucesso")));
              }).catchError((value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Erro: $value")));
              });
              setState(() {
                loading = false;
              });
            },
            child: Text("CADASTRO"),
          ),
          SizedBox(
            height: 10,
          ),
          if (loading) CircularProgressIndicator()
        ],
      ),
    );
  }
}
