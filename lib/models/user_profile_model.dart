class UserProfile {
  final String name;
  final int age;
  final String gender;
  final List<String> selectedGames;
  final List<String> visitedCities;
  final List<String> selectedBooks;
  int isSync;

  UserProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.selectedGames,
    required this.visitedCities,
    required this.selectedBooks,
    required this.isSync,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'selectedGames': selectedGames,
      'visitedCities': visitedCities,
      'selectedBooks': selectedBooks,
      'isSync': isSync,
    };
  }

  Map<String, dynamic> sqfLitetoMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'selectedGames': selectedGames.join(","),
      'visitedCities': visitedCities.join(","),
      'selectedBooks': selectedBooks.join(","),
      'isSync': isSync,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      selectedGames: List<String>.from(map['selectedGames'] ?? []),
      visitedCities: List<String>.from(map['visitedCities'] ?? []),
      selectedBooks: List<String>.from(map['selectedBooks'] ?? []),
      isSync: map['isSync'],
    );
  }
  factory UserProfile.fromSqfLiteMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      selectedGames:
          map['selectedGames'] != null &&
              (map['selectedGames'] as String).isNotEmpty
          ? (map['selectedGames'] as String).split(',')
          : [],
      visitedCities:
          map['visitedCities'] != null &&
              (map['visitedCities'] as String).isNotEmpty
          ? (map['visitedCities'] as String).split(',')
          : [],
      selectedBooks:
          map['selectedBooks'] != null &&
              (map['selectedBooks'] as String).isNotEmpty
          ? (map['selectedBooks'] as String).split(',')
          : [],
      isSync: map['isSync'],
    );
  }
}
