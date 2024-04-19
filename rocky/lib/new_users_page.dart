import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewUserPage extends StatelessWidget {
  NewUserPage({super.key});

  final nombreController = TextEditingController();
  final albumController = TextEditingController();
  final anioController = TextEditingController();
  final votoController = TextEditingController();
  final instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;

    if (args != null) {
      instance.collection('bandas').doc(args).get().then((value) {
        nombreController.text = value['Nombre de la banda'];
        albumController.text = value['Nombre del album'];
        anioController.text = value['Año del lanzamiento'].toString();
        votoController.text = value['Votos'].toString();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('agregar usuario nuevo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: albumController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: anioController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teléfono',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: votoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votos',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Add user to Firebase
                  //obtener los valores de los textfields
                  final data = {
                    'Nombre de la banda': nombreController.text,
                    'Nombre del album': albumController.text,
                    'Año de lanzamiento': int.parse(anioController.text),
                    'Votos': int.parse(votoController.text),
                  };
                    final respuesta =  await instance.collection('bandas').add(data);
                  print(respuesta);
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('Agregar'),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
