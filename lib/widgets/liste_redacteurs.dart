import 'package:app_redacteurs_firebase/models/redacteur.dart';
import 'package:app_redacteurs_firebase/views/ajout_redacteur.dart';
import 'package:app_redacteurs_firebase/widgets/card_redacteur.dart';
import 'package:flutter/material.dart';
import 'package:app_redacteurs_firebase/providers/redacteurProvider.dart';

class ListeRedacteurs extends StatefulWidget {
  const ListeRedacteurs({super.key});

  @override
  State<ListeRedacteurs> createState() => _ListeRedacteursState();
}

class _ListeRedacteursState extends State<ListeRedacteurs> {
  final RedacteurProvider redacteurProvider = RedacteurProvider();
  List<Redacteur> redacteurs = [];

  @override
  void initState() {
    super.initState();
    _getRedacteurs();
  }

  Future<void> _getRedacteurs() async {
    await redacteurProvider.recupererRedacteurs();
    setState(() {
      redacteurs = redacteurProvider.redacteurs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (redacteurs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Oops! Aucun rédacteur disponible pour le momment",
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const AjoutRedacteur()
                  )
                );
              },
              child: const Text('Ajouter un rédacteur'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: redacteurs.length,
      itemBuilder: (context, index) {
        final redacteur = redacteurs[index];
        return CardRedacteur(
          redacteur: redacteur, 
          onEdit: () {  }, 
          onDelete: () {  },);
      },
    );
  }
}
