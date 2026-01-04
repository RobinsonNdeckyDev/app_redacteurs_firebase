import 'package:app_redacteurs_firebase/models/redacteur.dart';
import 'package:app_redacteurs_firebase/providers/redacteurProvider.dart';
import 'package:app_redacteurs_firebase/views/update_redacteur.dart';
import 'package:flutter/material.dart';

class DetailsRedacteur extends StatefulWidget {
  final Redacteur redacteur;

  const DetailsRedacteur({super.key, required this.redacteur});

  @override
  State<DetailsRedacteur> createState() => _DetailsRedacteurState();
}

class _DetailsRedacteurState extends State<DetailsRedacteur> {
  final RedacteurProvider _redacteurProvider = RedacteurProvider();

  Future<void> _supprimerRedacteur() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmation',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Êtes-vous sûr de vouloir supprimer ce rédacteur ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _redacteurProvider.supprimerRedacteur(
                  widget.redacteur.id!,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Le rédacteur a été supprimé avec succès.'),
                  ),
                );
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          'Détails du rédacteur',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.pink,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),

          child: Column(
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: [
                      // Avatar par défaut
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.pinkAccent,
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),

                      const SizedBox(height: 30),

                      // Prrenom et Nom
                      Text(
                        '${widget.redacteur.prenom} ${widget.redacteur.nom}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Spécialité: ${widget.redacteur.specialite}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Adresse: ${widget.redacteur.adresse}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Téléphone: ${widget.redacteur.telephone}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Email: ${widget.redacteur.email}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Crée le: ${widget.redacteur.createdAt?.toLocal().toString() ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Mise à jour le: ${widget.redacteur.updatedAt?.toLocal().toString() ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateRedacteur(
                            redacteur: widget.redacteur,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Modifier',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 20),

                  ElevatedButton(
                    onPressed: _supprimerRedacteur,
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Supprimer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
