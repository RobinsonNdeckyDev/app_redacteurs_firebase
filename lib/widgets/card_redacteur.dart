import 'package:flutter/material.dart';
import 'package:app_redacteurs_firebase/models/redacteur.dart';

class CardRedacteur extends StatelessWidget {
  final Redacteur redacteur;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const CardRedacteur({
    super.key,
    required this.redacteur,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar par défaut
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),

            const SizedBox(height: 20),

            // Prénom et Nom
            Text(
              '${redacteur.prenom} ${redacteur.nom}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            // Actions Voir et Delete
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.blue),
                  onPressed: onView,
                  tooltip: 'Voir',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: 'Supprimer',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
