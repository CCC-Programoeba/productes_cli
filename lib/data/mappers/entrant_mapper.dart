import 'package:productes_cli/domain/entities/entrant.dart';

Entrant mapEntrant(Map<String, dynamic> json) {
  return Entrant(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    tipus: json['tipus'] as String?,
    allergens: List<String>.from(json['allergens']),
    price: (json['price'] as num).toDouble(),
    calories: json['calories'] as int,
    dietType: json['dietType'] == null ? null : List<String>.from(json['dietType']),
    additionalInfo: json['additionalInfo'] as String?,
    img: json['img'] as String?,
  );
}