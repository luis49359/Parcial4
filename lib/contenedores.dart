import 'package:firebase_flutter/mttoDestinos.dart';
import 'package:firebase_flutter/mttoReservas.dart';
import 'package:firebase_flutter/mttoClientes.dart';
import 'package:firebase_flutter/mttoVuelos.dart';
import 'package:flutter/material.dart';

class Contenedores extends StatefulWidget {
  Contenedores({Key? key}) : super(key: key);

  @override
  State<Contenedores> createState() => _ContenedoresState();
}

class _ContenedoresState extends State<Contenedores> {
  int menu_activo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      bottomNavigationBar: spotFooter(),
      body: spotBody(),
    );
  }

  Widget spotBody() {
    return IndexedStack(
        index: menu_activo,
        children: [mttoClientes(), mttoReservas(), mttoVuelos(), mttoDestinos()]);
  }

  Widget spotFooter() {
    List items = [
      Icons.person,
      Icons.event_busy,
      Icons.airplane_ticket,
      Icons.location_on,
    ];

    return Container(
      height: 60,
      decoration: BoxDecoration(color: Color.fromARGB(255, 8, 8, 8)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(4, (index) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    menu_activo = index;
                  });
                },
                icon: Icon(items[index],
                    color: menu_activo == index ? Color.fromARGB(255, 68, 129, 173) : Colors.white));
          }),
        ),
      ),
    );
  }
}
