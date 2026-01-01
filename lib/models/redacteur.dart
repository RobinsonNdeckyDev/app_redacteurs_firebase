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
      'id': id,
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'specialite': specialite,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  // Fonction de conversion de Map en Redacteur
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      prenom: map['prenom'],
      nom: map['nom'],
      email: map['email'],
      telephone: map['telephone'],
      adresse: map['adresse'],
      specialite: map['specialite'],
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : null,
    );
  }

  factory Redacteur.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Redacteur(
      id: doc.id,
      prenom: data['prenom'],
      nom: data['nom'],
      email: data['email'],
      telephone: data['telephone'],
      adresse: data['adresse'],
      specialite: data['specialite'],
      createdAt: data['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(data['createdAt']) : null,
      updatedAt: data['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(data['updatedAt']) : null,
    );
  }

  // Création d'un redacteur à partir d'un Map
  factory Redacteur.fromMapWithId(Map<String, dynamic> map, String id) {
    return Redacteur(
      id: id,
      prenom: map['prenom'] ?? '',
      nom: map['nom'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      adresse: map['adresse'] ?? '',
      specialite: map['specialite'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : null,
    );
  }

  // Copie d'un redacteur avec des modifications
  Redacteur copyWith({
    String? id,
    String? prenom,
    String? nom,
    String? email,
    String? telephone,
    String? adresse,
    String? specialite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Redacteur(
      id: id ?? this.id,
      prenom: prenom ?? this.prenom,
      nom: nom ?? this.nom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      adresse: adresse ?? this.adresse,
      specialite: specialite ?? this.specialite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Conversion d'un Redacteur en String
  @override
  String toString() {
    return 'Redacteur{id: $id, prenom: $prenom, nom: $nom, email: $email, telephone: $telephone, adresse: $adresse, specialite: $specialite, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

