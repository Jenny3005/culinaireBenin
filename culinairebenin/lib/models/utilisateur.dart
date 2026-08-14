class Utilisateur {
  final int id;
  final String nom;
  final String prenom;
  final String email;
  final String? photo;
  final String? role;

  Utilisateur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    this.photo,
    this.role,
  });

  // Convertit la réponse JSON de Laravel en un objet Utilisateur Dart
  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      photo: json['photo'],
      role: json['role'],
    );
  }
}