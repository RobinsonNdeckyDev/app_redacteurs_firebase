import 'package:app_redacteurs_firebase/models/redacteur.dart';
import 'package:app_redacteurs_firebase/views/ajout_redacteur.dart';
import 'package:app_redacteurs_firebase/views/pageAccueil.dart';
import 'package:app_redacteurs_firebase/widgets/card_redacteur.dart';
import 'package:app_redacteurs_firebase/widgets/details_redacteur.dart';
import 'package:flutter/material.dart';
import 'package:app_redacteurs_firebase/providers/redacteurProvider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ListeRedacteurs extends StatefulWidget {
  const ListeRedacteurs({super.key});

  @override
  State<ListeRedacteurs> createState() => _ListeRedacteursState();
}

class _ListeRedacteursState extends State<ListeRedacteurs> {
  final RedacteurProvider redacteurProvider = RedacteurProvider();
  List<Redacteur> redacteurs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getRedacteurs();
  }

  Future<void> _getRedacteurs() async {
    await redacteurProvider.recupererRedacteurs();
    if (mounted) {
      setState(() {
        redacteurs = redacteurProvider.redacteurs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PageAccueil()),
          ),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          "Liste des rédacteurs",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.pink,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      body: _isLoading
          ? const Center(
            child: CircularProgressIndicator(
              color: Colors.pink, 
              strokeWidth: 6,
              semanticsLabel: 'Chargement des rédacteurs',
              semanticsValue: 'En cours',
            ),
          )
          : _body(),
    );
  }

  Widget _body() {
    
    if (redacteurProvider.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Erreur: ${redacteurProvider.error}",
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (redacteurs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Oops! Aucun rédacteur disponible pour le moment",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AjoutRedacteur(),
                  ),
                );
              },
              child: const Text('Ajouter un rédacteur'),
            ),
          ],
        ),
      );
    }

    return ResponsiveGridList(
      minItemWidth: 150,
      horizontalGridSpacing: 16,
      verticalGridSpacing: 16,
      horizontalGridMargin: 16,
      verticalGridMargin: 16,
      children: redacteurs
          .map(
            (redacteur) => CardRedacteur(
              redacteur: redacteur,
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsRedacteur(redacteur: redacteur),
                  ),
                );
              },
              onDelete: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Confirmer la suppression',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.pinkAccent
                      ),
                    ),
                    content: Text('Êtes-vous sûr de vouloir supprimer ce rédacteur ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Annuler',
                          style: TextStyle(color: Colors.pinkAccent),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await redacteurProvider.supprimerRedacteur(redacteur.id!);
                          if (mounted) {
                            setState(() {
                              redacteurs.removeWhere((r) => r.id == redacteur.id);
                            });
                          }
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context, ) => ListeRedacteurs())
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Redacteur supprimé avec succès!"), 
                              backgroundColor: Colors.pink,
                              behavior: SnackBarBehavior.floating,
                            )
                          );
                        },
                        child: Text('Supprimer', style: TextStyle(color: Colors.pink)),
                      ),
                    ],
                  ));
                },
              ),
            )
          .toList(),
    );
  }
}
