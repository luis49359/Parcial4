import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mttoDestinos extends StatefulWidget {
  mttoDestinos({Key? key}) : super(key: key);

  @override
  State<mttoDestinos> createState() => _mttoDestinosState();
}

class _mttoDestinosState extends State<mttoDestinos> {
  final TextEditingController _idDestinoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();

  final CollectionReference _destinos =
      FirebaseFirestore.instance.collection('destinos');

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
                    controller: _idDestinoController,
                    decoration: const InputDecoration(
                      labelText: 'ID Destino',
                    ),
                  ),
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'nombre'),
                  ),
                  TextField(
                    controller: _horarioController,
                    decoration: const InputDecoration(
                      labelText: 'Horario',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Crear'),
                    onPressed: () async {
                      final String nombre = _nombreController.text;
                      final int? idDestino =
                          int.tryParse(_idDestinoController.text);
                      final String idHorario = _horarioController.text;
                      if (idDestino != null) {
                        await _destinos.add({
                          "nombre": nombre,
                          "idDestino": idDestino,
                          "idHorario": idHorario
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Destino ' +
                                idDestino.toString() +
                                ' creada exitosamente')));
                        _nombreController.text = "";
                        _idDestinoController.text = "";
                        _horarioController.text = "";
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
      _idDestinoController.text = documentSnapshot['id_destino'].toString();
      _horarioController.text = documentSnapshot['id_horario'].toString();
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
                    controller: _idDestinoController,
                    decoration: const InputDecoration(
                      labelText: 'ID Destino',
                    ),
                  ),
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: _horarioController,
                    decoration: const InputDecoration(
                      labelText: 'Horario',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String nombre = _nombreController.text;
                      final int? idDestino =
                          int.tryParse(_idDestinoController.text);
                      final String idHorario = _horarioController.text;
                      if (idDestino != null) {
                        await _destinos.doc(documentSnapshot!.id).update({
                          "nombre": nombre,
                          "id_destino": idDestino,
                          "id_horario": idHorario
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Reserva ' +
                                idDestino.toString() +
                                ' editada exitosamente')));
                        _nombreController.text = "";
                        _idDestinoController.text = "";
                        _horarioController.text = "";
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
    await _destinos.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destino eliminado exitosamente')));
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
            "DESTINOS",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.list_outlined)
        ]),
      ),
    );
  }

  cuerpo() {
    return StreamBuilder(
      stream: _destinos.snapshots(),
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
                  title:
                      Text("ID " + documentSnapshot['id_destino'].toString()),
                  subtitle:
                      Text("Destino: " + documentSnapshot['nombre'].toString()),
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
