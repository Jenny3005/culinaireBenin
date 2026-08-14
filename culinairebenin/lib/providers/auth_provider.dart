import 'package:flutter/material.dart';
import '../models/utilisateur.dart';

class AuthProvider extends ChangeNotifier {
  Utilisateur? _utilisateur;

  // Getter pour accéder facilement à l'utilisateur
  Utilisateur? get utilisateur => _utilisateur;

  // Méthode pour enregistrer l'utilisateur après le login
  void setUtilisateur(Utilisateur user) {
    _utilisateur = user;
    notifyListeners(); // Informe Flutter de mettre à jour les écrans !
  }
}