class Team {
  final int? id;
  final String name;
  final int foundationYear;
  final String? lastChampionship;

  Team({
    this.id,
    required this.name,
    required this.foundationYear,
    this.lastChampionship,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'foundationYear': foundationYear,
      'lastChampionship': lastChampionship,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      name: map['name'],
      foundationYear: map['foundationYear'],
      lastChampionship: map['lastChampionship'],
    );
  }
}
