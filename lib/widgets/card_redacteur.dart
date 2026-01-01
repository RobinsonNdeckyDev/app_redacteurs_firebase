import 'package:flutter/material.dart';
import 'package:app_redacteurs_firebase/models/redacteur.dart';

class CardRedacteur extends StatelessWidget {
  
  final Redacteur redacteur;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CardRedacteur({
    super.key,
    required this.redacteur,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.visibility, color: Colors.blue),
            
            const SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    redacteur.nom,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    redacteur.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),
            
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
