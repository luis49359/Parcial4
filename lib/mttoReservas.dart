import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mttoReservas extends StatefulWidget {
  mttoReservas({Key? key}) : super(key: key);

  @override
  State<mttoReservas> createState() => _mttoReservasState();
}

class _mttoReservasState extends State<mttoReservas> {
  final TextEditingController _idReservaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  final CollectionReference _reservas =
      FirebaseFirestore.instance.collection('Reservas');
  final CollectionReference _vuelos =
      FirebaseFirestore.instance.collection('Vuelos');
  List<String> listId = [];
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idReservaController,
                    decoration: const InputDecoration(
                      labelText: 'ID Reserva',
                    ),
                  ),
                  TextField(
                    controller: _estadoController,
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                  Text("Vuelo"),
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    onChanged: (String? value) {},
                    items: listId.map<DropdownMenuItem<String>>((String value) {
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
                      final String estado = _estadoController.text;
                      final int? idReserva =
                          int.tryParse(_idReservaController.text);
                      final int? vuelo = int.tryParse(dropdownValue);
                      if (vuelo != null && idReserva != null) {
                        await _reservas.add({
                          "estado": estado,
                          "idReservas": idReserva,
                          "id_vuelo": vuelo
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Reserva ' +
                                idReserva.toString() +
                                ' creada exitosamente')));
                      }
                      _estadoController.text = "";
                      _idReservaController.text = "";

                      Navigator.of(context).pop();
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
      _estadoController.text = documentSnapshot['estado'].toString();
      _idReservaController.text = documentSnapshot['idReservas'].toString();
      dropdownValue = documentSnapshot['id_vuelo'].toString();
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idReservaController,
                    decoration: const InputDecoration(
                      labelText: 'ID Reserva',
                    ),
                  ),
                  TextField(
                    controller: _estadoController,
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                  Text("Vuelo"),
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    onChanged: (String? value) {
                      dropdownValue = value!;
                    },
                    items: listId.map<DropdownMenuItem<String>>((String value) {
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
                      final String estado = _estadoController.text;
                      final int? idReserva =
                          int.tryParse(_idReservaController.text);
                      final int? vuelo = int.tryParse(dropdownValue);
                      if (vuelo != null && idReserva != null) {
                        await _reservas.doc(documentSnapshot!.id).update({
                          "estado": estado,
                          "idReservas": idReserva,
                          "id_vuelo": vuelo
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Reserva ' +
                                idReserva.toString() +
                                ' editada exitosamente')));
                      }
                      _estadoController.text = "";
                      _idReservaController.text = "";
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _reservas.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reserva eliminada exitosamente')));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: barraApp(),
      body: cuerpo(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  barraApp() {
    return AppBar(
      backgroundColor: Colors.blue[50],
      elevation: 10,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "RESERVAS",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.list_outlined)
        ]),
      ),
    );
  }

  cuerpo() {
    if (listId.isEmpty) {
      _vuelos.snapshots().forEach(
        (element) {
          element.docs.asMap().values.forEach((value) {
            listId.add(value["idVuelo"].toString());
            dropdownValue = listId.first;
          });
        },
      );
    }
    return StreamBuilder(
      stream: _reservas.snapshots(),
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
                  title: Text("ID Reserva " + documentSnapshot['idReservas'].toString()),
                  subtitle: Text("Estado " +documentSnapshot['estado'].toString()),
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
