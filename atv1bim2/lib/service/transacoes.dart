class Transacao {
  final int id;
  final String name;
  final double values;

  Transacao({required this.id, required this.name, required this.values});

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      name: json['name'],
      values: json['values'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'values': values,
    };
  }
}
