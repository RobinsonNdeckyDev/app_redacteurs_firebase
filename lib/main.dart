import 'package:app_redacteurs_firebase/views/pageAccueil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Point d'entrée de l'application
Future<void> main() async {
  // Initialisation Firebase et affichage de l'application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MonAppli());
}

// Classe principale de l'application
class MonAppli extends StatelessWidget {

  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App rédacteurs Firebase',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: const PageAccueil(),
    );
  }
  
}
