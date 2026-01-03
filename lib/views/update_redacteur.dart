import 'package:app_redacteurs_firebase/models/redacteur.dart';
import 'package:app_redacteurs_firebase/providers/redacteurProvider.dart';
import 'package:app_redacteurs_firebase/views/liste_redacteurs.dart';
import 'package:flutter/material.dart';

class UpdateRedacteur extends StatefulWidget {
  final Redacteur redacteur;

  const UpdateRedacteur({super.key, required this.redacteur});

  @override
  State<UpdateRedacteur> createState() => _UpdateRedacteurState();
}

class _UpdateRedacteurState extends State<UpdateRedacteur> {
  final RedacteurProvider _redacteurProvider = RedacteurProvider();

  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _specialiteController = TextEditingController();
  final _adresseControlle = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomController.text = widget.redacteur.nom;
    _prenomController.text = widget.redacteur.prenom;
    _emailController.text = widget.redacteur.email;
    _telephoneController.text = widget.redacteur.telephone;
    _specialiteController.text = widget.redacteur.specialite ?? '';
    _adresseControlle.text = widget.redacteur.adresse ?? '';
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _specialiteController.dispose();
    _adresseControlle.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirmation',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.pink
          ),
        ),
        content: const Text(
          'Êtes-vous sûr de vouloir mettre à jour ce rédacteur ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Annuler',
              style: TextStyle(color: Colors.pinkAccent),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Confirmer',
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ],
      ),
    ).then((confirmed) async {
      if (confirmed == true) {
        if (_formKey.currentState!.validate()) {
          final updatedRedacteur = Redacteur(
            id: widget.redacteur.id,
            nom: _nomController.text,
            prenom: _prenomController.text,
            email: _emailController.text,
            telephone: _telephoneController.text,
            specialite: _specialiteController.text,
            adresse: _adresseControlle.text,
            createdAt: widget.redacteur.createdAt,
          );

          await _redacteurProvider.modifierRedacteur(
            widget.redacteur.id!,
            updatedRedacteur,
          );

          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListeRedacteurs()),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Le rédacteur a été mis à jour avec succès.'),
            ),
          );
        }
      }
    });
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
          'Modification du rédacteur',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.pink,
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Modifier le rédacteur",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink,
                ),
              ),

              const SizedBox(height: 50),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _prenomController,
                      decoration: InputDecoration(labelText: 'Prénom'),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Veuillez entrer un prénom';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(labelText: 'Nom'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Veuillez entrer un nom';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Veuillez entrer un email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _telephoneController,
                      decoration: InputDecoration(labelText: 'Téléphone'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Veuillez entrer un numéro de téléphone';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _specialiteController,
                      decoration: InputDecoration(labelText: 'Spécialité'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Veuillez entrer une spécialité';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _adresseControlle,
                      decoration: InputDecoration(labelText: 'Adresse'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Veuillez entrer une adresse';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 45,
                            ),
                            backgroundColor: Colors.pinkAccent,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListeRedacteurs(),
                              ),
                            );
                          },
                          child: Text(
                            'Annuler',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),

                        const SizedBox(width: 40),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 45,
                            ),
                            backgroundColor: Color(0xFFE91E63),
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            'Modifier',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
