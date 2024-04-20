import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final users = firestore.collection('bandas').snapshots();

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listaUsuarios = snapshot.data!.docs; // La lista de documentos

            return ListView.builder(
              itemCount: listaUsuarios.length,
              itemBuilder: (context, index) {
                final user = listaUsuarios[index];

                // user.id;

                return ListTile(
                  title: Text(user['Nombre de la banda']),
                  subtitle: Text(user['Nombre del album']),
                  leading: Text('${user['Año de lanzamiento']}'),
                  trailing: Text('Votos:  ${user['Votos']}'),
                  onTap: () async {
                final id = user.id;
                  await firestore.collection('bandas').doc(id).update({
                      'Votos': FieldValue.increment(1),
                    });
                    setState(() {});
                  },  
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_user');
        },
        tooltip: 'Nueva banda',
        child: const Icon(Icons.add),
      ),
    );
  }
}
