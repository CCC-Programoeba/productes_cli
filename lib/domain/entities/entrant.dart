// 
class Entrant {
  final String id;
  final String name;
  final String description;
  final String? tipus;
  final List<String> allergens;
  final double price;
  final int calories;
  final List<String>? dietType;
  final String? additionalInfo;
  final String? img;

  /// Els arguments amb nom fan explícit el significat de cada dada.
  Entrant(
      {required this.id,
      required this.name,
      required this.description,
      this.tipus,
      required this.allergens,
      required this.price,
      required this.calories,
      this.dietType,
      this.additionalInfo,
      this.img});

  /// Primera aproximació: el model encara coneix les claus del JSON.
  /// En la pràctica 3 traslladarem aquesta conversió a la capa de dades.

  factory Entrant.fromJson(Map<String, dynamic> json) {
    // Hacemos un Map de un String-> donde las claves son texto:'id','name'...dynamic->los valores pueden ser de distintos tipos

    return Entrant(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      tipus: json['tipus'] as String?,
      allergens: List<String>.from(json['allergens']),
      price: (json['price'] as num).toDouble(), //sea el num que sea, a double
      calories: json['calories'] as int,
      //dietType: json ['dietType']==null ? null : List<String>.from(json['dietType']),       los tabs e intros le dan igual
      dietType: json['dietType'] == null // si es null o no
          ? null // es null
          : List<String>.from(json['dietType']), // no es null
      additionalInfo: json['additionalInfo'] as String?,
      img: json['img'] as String?,
    );

    // throw UnimplementedError("P1: conversió JSON a Entrant");
  }
}
