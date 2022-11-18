import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mttoVuelos extends StatefulWidget {
  mttoVuelos({Key? key}) : super(key: key);

  @override
  State<mttoVuelos> createState() => _vuelosState();
}

class _vuelosState extends State<mttoVuelos> {
  final TextEditingController _idVueloController = TextEditingController();
  final TextEditingController _dispController = TextEditingController();
  final TextEditingController _tipoVueloController = TextEditingController();
  final TextEditingController _codigoAvionController = TextEditingController();

  final CollectionReference _vuelos =
      FirebaseFirestore.instance.collection('Vuelos');
  final CollectionReference _destinos =
      FirebaseFirestore.instance.collection('destinos');

  List<String> listIdDestino = [];
  String dropdownValueDestino = "";
  List<String> listDestinos = [];

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
                    controller: _dispController,
                    decoration:
                        const InputDecoration(labelText: 'Disponibilidad'),
                  ),
                  TextField(
                    controller: _tipoVueloController,
                    decoration: const InputDecoration(labelText: 'Tipo Vuelo'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idVueloController,
                    decoration: const InputDecoration(
                      labelText: 'ID Vuelo',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _codigoAvionController,
                    decoration: const InputDecoration(
                      labelText: 'ID Avión',
                    ),
                  ),
                  Text("Destino"),
                  DropdownButtonFormField<String>(
                    value: dropdownValueDestino,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {
                      setState(() {
                        dropdownValueDestino = value!;
                      });
                    },
                    onChanged: (String? value) {
                      dropdownValueDestino = value!;
                    },
                    items: listDestinos
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
                      final String disponibilidad = _dispController.text;
                      final String tipo = _tipoVueloController.text;
                      final int? avionId =
                          int.tryParse(_codigoAvionController.text);
                      final int? destinoId = int.tryParse(listIdDestino[
                          listDestinos.indexOf(dropdownValueDestino)]);
                      final int? id = int.tryParse(_idVueloController.text);
                      if (avionId != null && destinoId != null && id != null) {
                        await _vuelos.add({
                          "idVuelo": id,
                          "disponibilidad": disponibilidad,
                          "Avion_codigo": avionId,
                          "id_destinos": destinoId,
                          "tipo_vuelo": tipo,
                        });

                        _idVueloController.text = "";
                        _dispController.text = "";
                        _tipoVueloController.text = "";
                        _codigoAvionController.text = "";
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
      _idVueloController.text = documentSnapshot['idVuelo'].toString();
      _dispController.text = documentSnapshot['disponibilidad'].toString();
      _tipoVueloController.text = documentSnapshot['tipo_vuelo'].toString();
      dropdownValueDestino = listDestinos[
          listIdDestino.indexOf(documentSnapshot['id_destinos'].toString())];
      _codigoAvionController.text = documentSnapshot['Avion_codigo'].toString();
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
                    controller: _dispController,
                    decoration:
                        const InputDecoration(labelText: 'Disponibilidad'),
                  ),
                  TextField(
                    controller: _tipoVueloController,
                    decoration: const InputDecoration(labelText: 'Tipo Vuelo'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idVueloController,
                    decoration: const InputDecoration(
                      labelText: 'ID Vuelo',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _codigoAvionController,
                    decoration: const InputDecoration(
                      labelText: 'ID Avión',
                    ),
                  ),
                  Text("Destino"),
                  DropdownButtonFormField<String>(
                    value: dropdownValueDestino,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (String? value) {
                      setState(() {
                        dropdownValueDestino = value!;
                      });
                    },
                    onChanged: (String? value) {
                      dropdownValueDestino = value!;
                    },
                    items: listDestinos
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
                      final String disponibilidad = _dispController.text;
                      final String tipo = _tipoVueloController.text;
                      final int? avionId = int.tryParse(_codigoAvionController.text);
                      final int? destinoId = int.tryParse(listIdDestino[
                          listDestinos.indexOf(dropdownValueDestino)]);
                      final int? id = int.tryParse(_idVueloController.text);
                      if (avionId != null && destinoId != null && id != null) {
                        await _vuelos.doc(documentSnapshot!.id).update({
                          "idVuelo": id,
                          "disponibilidad": disponibilidad,
                          "Avion_codigo": avionId,
                          "id_destinos": destinoId,
                          "tipo_vuelo": tipo,
                        });
                      }
                      _idVueloController.text = "";
                      _dispController.text = "";
                      _tipoVueloController.text = "";
                      _codigoAvionController.text = "";
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
    await _vuelos.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El vuelo fue eliminado correctamente')));
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
            "VUELOS",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.list_outlined)
        ]),
      ),
    );
  }

  cuerpo() {
    if (listIdDestino.isEmpty) {
      _destinos.snapshots().forEach(
        (element) {
          element.docs.asMap().values.forEach((value) {
            listIdDestino.add(value["id_destino"].toString());
            listDestinos.add(value["nombre"].toString());
            dropdownValueDestino = listDestinos.first;
            print(value.data());
          });
        },
      );
    }
    return StreamBuilder(
      stream: _vuelos.snapshots(),
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
                  title: Text(
                      "ID Vuelo: " + documentSnapshot['idVuelo'].toString()),
                  subtitle: Text("Código Avión: " +
                      documentSnapshot['Avion_codigo'].toString()),
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
