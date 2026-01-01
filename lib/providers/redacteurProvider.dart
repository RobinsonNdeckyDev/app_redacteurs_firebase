import 'package:app_redacteurs_firebase/models/redacteur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RedacteurProvider extends ChangeNotifier {
  
  // FirebaseFirestore pour accéder à la base de données Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Nom de la collection dans Firestore
  final String nomCollection = 'redacteurs';
  // Liste des rédacteurs
  List<Redacteur> _redacteurs = [];
  // Indicateur de chargement
  bool _isLoading = false;
  // Message d'erreur
  String? _error;

  // Getters
  List<Redacteur> get redacteurs => _redacteurs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // CREATE - Ajout d'un rédacteur
  Future<bool> ajouterRedacteur(Redacteur redacteur) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestore.collection(nomCollection).add(redacteur.toMap());

      // Rafraîchissement de la liste des rédacteurs après l'ajout
      await recupererRedacteurs(); 
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de l\'ajout : ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // READ - Récupérer tous les rédacteurs
  Future<void> recupererRedacteurs() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Récupération des données depuis Firestore
      QuerySnapshot snapshot = await _firestore
          .collection(nomCollection)
          .orderBy('createdAt', descending: true)
          .get();

      // Mise à jour de la liste des rédacteurs avec les données Firestore
      _redacteurs = snapshot.docs
          .map((doc) => Redacteur.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors de la récupération : ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // READ - Récupérer un rédacteur par ID
  Future<Redacteur?> recupererRedacteurParId(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(nomCollection).doc(id).get();

      // Récupération des données depuis Firestore
      if (doc.exists) {
        return Redacteur.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>);
      }
      return null;
    } catch (e) {
      _error = 'Erreur lors de la récupération : ${e.toString()}';
      notifyListeners();
      return null;
    }
  }

  // READ - Stream des rédacteurs en temps réel
  Stream<List<Redacteur>> streamRedacteurs() {
    return _firestore
        .collection(nomCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Redacteur.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    });
  }

  // UPDATE - Modification d'un rédacteur
  Future<bool> modifierRedacteur(String id, Redacteur redacteur) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // Préparation des données à mettre à jour
      Map<String, dynamic> data = redacteur.toMap();
      data['updatedAt'] = FieldValue.serverTimestamp();
      data.remove('createdAt'); // Ne pas modifier la date de création

      // Mise à jour dans Firestore
      await _firestore.collection(nomCollection).doc(id).update(data);

      // Rafraîchissement de la liste des rédacteurs après la modification
      await recupererRedacteurs();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de la modification : ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // DELETE - Suppression d'un rédacteur
  Future<bool> supprimerRedacteur(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestore.collection(nomCollection).doc(id).delete();

      _redacteurs.removeWhere((r) => r.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de la suppression : ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // SEARCH - Rechercher par nom ou prénom
  Future<List<Redacteur>> rechercherRedacteurs(String query) async {
    try {
      String searchLower = query.toLowerCase();
      
      // Filtrer localement (plus efficace pour la recherche)
      return _redacteurs.where((redacteur) {
        return redacteur.nom.toLowerCase().contains(searchLower) ||
               redacteur.prenom.toLowerCase().contains(searchLower) ||
               redacteur.email.toLowerCase().contains(searchLower) ||
               redacteur.specialite?.toLowerCase().contains(searchLower) == true;
      }).toList();
    } catch (e) {
      _error = 'Erreur lors de la recherche : ${e.toString()}';
      notifyListeners();
      return [];
    }
  }

  // Filtre par spécialité
  List<Redacteur> filtrerParSpecialite(String specialite) {
    return _redacteurs
        .where((r) => r.specialite?.toLowerCase() == specialite.toLowerCase())
        .toList();
  }

  // Obtenir toutes les spécialités uniques
  List<String?> getSpecialites() {
    return _redacteurs.map((r) => r.specialite).toSet().toList()..sort();
  }

  // Réinitialiser l'erreur
  void clearError() {
    _error = null;
    notifyListeners();
  }
}