import 'package:cloud_firestore/cloud_firestore.dart';

class Redacteur {
  final String? id;
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final String adresse;
  final String? specialite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Constructeur de la classe Redacteur
  Redacteur({
    this.id,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.adresse,
    this.specialite,
    this.createdAt,
    this.updatedAt,
  });

  // Fonction de conversion de Redacteur en Map pour Firebase
  Map<String, dynamic> toMap() {
    return {
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'specialite': specialite,
    };
  }

  factory Redacteur.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Redacteur(
      id: doc.id,
      prenom: data['prenom'] ?? '',
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      telephone: data['telephone'] ?? '',
      adresse: data['adresse'] ?? '',
      specialite: data['specialite'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}
