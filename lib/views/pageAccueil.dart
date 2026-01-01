import 'package:app_redacteurs_firebase/widgets/liste_redacteurs.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Magazine Infos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.pink,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.grey[50],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.edit_note, size: 54, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    'Rédacteurs',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Gérez vos rédacteurs en un clic',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // Menus de navigation
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home_rounded, color: Colors.pink),
                    title: Text('Accueil'),
                    onTap: () {
                      
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add_rounded, color: Colors.pink),
                    title: Text('Ajouter un rédacteur'),
                    onTap: () {
                      
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_rounded, color: Colors.pink),
                    title: Text('Informations sur les rédacteurs'),
                    onTap: () {
                      
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'v1.0.0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
      
      body: const ListeRedacteurs()
    );
  }
}
