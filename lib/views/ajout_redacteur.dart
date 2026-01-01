import 'package:flutter/material.dart';
import 'package:app_redacteurs_firebase/models/redacteur.dart';
import 'package:app_redacteurs_firebase/providers/redacteurProvider.dart';

class AjoutRedacteur extends StatefulWidget {
  const AjoutRedacteur({super.key});

  @override
  State<AjoutRedacteur> createState() => _AjoutRedacteurState();
}

class _AjoutRedacteurState extends State<AjoutRedacteur> {
  RedacteurProvider _redacteurProvider = RedacteurProvider();

  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _specialiteController = TextEditingController();
  final _adresseControlle = TextEditingController();

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
    if (_formKey.currentState!.validate()) {
      final newRedacteur = Redacteur(
        nom: _nomController.text,
        prenom: _prenomController.text,
        email: _emailController.text,
        telephone: _telephoneController.text,
        specialite: _specialiteController.text,
        adresse: _adresseControlle.text,
      );
      await _redacteurProvider.ajouterRedacteur(newRedacteur);
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Information'),
            content: const Text('Le rédacteur a été ajouté avec succès.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: Icon(Icons.arrow_back, color: Colors.white)
        ),
        centerTitle: true,
        title: Text(
          "Ajout rédacteur",
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

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                "Ajouter un nouveau rédacteur", 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink
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
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.phone,
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
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                            backgroundColor: Colors.pinkAccent,
                          ),
                          onPressed: dispose,
                          child: Text(
                            'Annuler', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                        ),

                        const SizedBox(width: 40),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                            backgroundColor: Color(0xFFE91E63),
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            'Ajouter', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
