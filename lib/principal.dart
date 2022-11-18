
import 'package:firebase_flutter/contenedores.dart';
import 'package:flutter/material.dart';


class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // text fields' controllers
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('SKY FLIES')),
        ),
        body: Contenedores());
  }
}
