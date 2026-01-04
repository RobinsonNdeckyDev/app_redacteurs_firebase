import 'package:app_redacteurs_firebase/views/ajout_redacteur.dart';
import 'package:app_redacteurs_firebase/views/liste_redacteurs.dart';
import 'package:flutter/material.dart';

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Magazine Infos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.pink,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.grey[50],
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home_rounded, color: Colors.pink),
                      title: Text('Accueil'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageAccueil(),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 1, color: Colors.pinkAccent),

                    ListTile(
                      leading: Icon(Icons.person_add_rounded, color: Colors.pink),
                      title: Text('Ajouter un rédacteur'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AjoutRedacteur(),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 1, color: Colors.pinkAccent),

                    ListTile(
                      leading: Icon(Icons.info_rounded, color: Colors.pink),
                      title: Text('Informations sur les rédacteurs'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListeRedacteurs(),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 1, color: Colors.pinkAccent),
                  ]
                ,)
              )
              
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/images/nohassi-img.jpg')
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Bienvenue au Magazine Infos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Votre magazine numérique, votre source d\'ininspiration',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Magazine infos est bien plus qu\'un simple magazine d\'informations. C\'est votre passerelle vers le monde, une source inestimable de connaissances et d\'actualités soigneusement sélactionnées pour vous éclairer sur les enjeux mondiaux, la culture, la science, et voir même le divertissement(jeux).',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),


            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      const Icon(Icons.phone, size: 40, color: Colors.pink,),
                      const SizedBox(height: 8),
                      Text(
                        'Tel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      const Icon(Icons.mail, size: 40, color: Colors.pink,),
                      const SizedBox(height: 8),
                      Text(
                        'Mail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      const Icon(Icons.share, size: 40, color: Colors.pink,),
                      const SizedBox(height: 8),
                      Text(
                        'Partage',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/images/nohassi1.jpg',
                    width: 150,
                    height: 150,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),

                ClipRRect(
                  child: Image.asset(
                    'assets/images/nohassi2.jpg',
                    width: 150,
                    height: 150,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjoutRedacteur()),
          );
        },
      ),
    );
  }
}
