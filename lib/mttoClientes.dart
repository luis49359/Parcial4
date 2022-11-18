import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mttoClientes extends StatefulWidget {
  mttoClientes({Key? key}) : super(key: key);

  @override
  State<mttoClientes> createState() => _mttoClientesState();
}

class _mttoClientesState extends State<mttoClientes> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaNacController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('clientes');

  final CollectionReference _reservas =
      FirebaseFirestore.instance.collection('Reservas');

  List<String> listIdReserva = [];
  String dropdownValue = "";

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _cedulaController,
                    decoration: const InputDecoration(
                      labelText: 'Cédula',
                    ),
                  ),
                  TextField(
                    controller: _fechaNacController,
                    decoration:
                        const InputDecoration(labelText: 'Fecha Nacimiento'),
                  ),
                  TextField(
                    controller: _sexoController,
                    decoration: const InputDecoration(labelText: 'Sexo'),
                  ),
                  TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    controller: _tipoController,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                  ),
                  Text("Reserva"),
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                    },
                    items: listIdReserva
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Crear'),
                    onPressed: () async {
                      final String nombre = _nombreController.text;
                      final String apellido = _apellidoController.text;
                      final String fecha = _fechaNacController.text;
                      final String sexo = _sexoController.text;
                      final String tipo = _tipoController.text;
                      final String usuario = _usuarioController.text;
                      final int? cedula = int.tryParse(_cedulaController.text);
                      final int? reserva = int.tryParse(dropdownValue);
                      if (reserva != null && cedula != null) {
                        await _clientes.add({
                          "nombre": nombre,
                          "apellido": apellido,
                          "fecha_nacimiento": fecha,
                          "cedula": cedula,
                          "sexo": sexo,
                          "tipo": tipo,
                          "usuario": usuario,
                          "idReservas": reserva
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Cliente ' +
                                usuario +
                                ' agregado exitosamente')));
                        _nombreController.text = "";
                        _apellidoController.text = "";
                        _fechaNacController.text = "";
                        _cedulaController.text = "";
                        _sexoController.text = "";
                        _usuarioController.text = "";
                        _tipoController.text = "";
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nombreController.text = documentSnapshot['nombre'].toString();
      _apellidoController.text = documentSnapshot['apellido'].toString();
      _fechaNacController.text =
          documentSnapshot['fecha_nacimiento'].toString();
      _cedulaController.text = documentSnapshot['cedula'].toString();
      _sexoController.text = documentSnapshot['sexo'].toString();
      _usuarioController.text = documentSnapshot['usuario'].toString();
      _tipoController.text = documentSnapshot['tipo'].toString();
      dropdownValue = documentSnapshot['idReservas'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _cedulaController,
                    decoration: const InputDecoration(
                      labelText: 'Cédula',
                    ),
                  ),
                  TextField(
                    controller: _fechaNacController,
                    decoration:
                        const InputDecoration(labelText: 'Fecha Nacimiento'),
                  ),
                  TextField(
                    controller: _sexoController,
                    decoration: const InputDecoration(labelText: 'Sexo'),
                  ),
                  TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    controller: _tipoController,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                  ),
                  Text("Reserva"),
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                    },
                    items: listIdReserva
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String nombre = _nombreController.text;
                      final String apellido = _apellidoController.text;
                      final String fecha = _fechaNacController.text;
                      final String sexo = _sexoController.text;
                      final String tipo = _tipoController.text;
                      final String usuario = _usuarioController.text;
                      final int? cedula = int.tryParse(_cedulaController.text);
                      final int? reserva = int.tryParse(dropdownValue);
                      if (reserva != null && cedula != null) {
                        await _clientes.doc(documentSnapshot!.id).update({
                          "nombre": nombre,
                          "apellido": apellido,
                          "fecha_nacimiento": fecha,
                          "cedula": cedula,
                          "sexo": sexo,
                          "tipo": tipo,
                          "usuario": usuario,
                          "idReservas": reserva
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Cliente ' +
                                usuario +
                                ' editado exitosamente')));
                        _nombreController.text = "";
                        _apellidoController.text = "";
                        _fechaNacController.text = "";
                        _cedulaController.text = "";
                        _sexoController.text = "";
                        _usuarioController.text = "";
                        _tipoController.text = "";
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _clientes.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente eliminado exitosamente')));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: barraSpotApp(),
      body: cuerpoSpot(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  barraSpotApp() {
    return AppBar(
      backgroundColor: Colors.blue[50],
      elevation: 10,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "CLIENTES",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.list_outlined)
        ]),
      ),
    );
  }

  cuerpoSpot() {
    if (listIdReserva.isEmpty) {
      _reservas.snapshots().forEach(
        (element) {
          element.docs.asMap().values.forEach((value) {
            listIdReserva.add(value["idReservas"].toString());
            dropdownValue = listIdReserva.first;
          });
        },
      );
    }
    return StreamBuilder(
      stream: _clientes.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['usuario'].toString()),
                  subtitle: Text(documentSnapshot['nombre'].toString() +
                      " " +
                      documentSnapshot['apellido'].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _update(documentSnapshot)),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _delete(documentSnapshot.id)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
