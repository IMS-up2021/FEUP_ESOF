class FamilyMember {
  final String? degree;
  final String? name;
  final String? age;
  final String? occupation;
  final String? birth;
  final String? marriage;
  final String? death;
  final String? family;

  const FamilyMember({
    required this.degree,
    required this.name,
    required this.age,
    required this.occupation,
    required this.birth,
    required this.marriage,
    required this.death,
    this.family,
  });

  toJson() {
    return {
      "degree": degree,
      "name": name,
      "age": age,
      "occupation": occupation,
      "birth": birth,
      "marriage": marriage,
      "death": death,
      "family": family,
    };
  }
}
