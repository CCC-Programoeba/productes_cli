import 'package:productes_cli/data/services/productes_service.dart';

class TestService implements ProductesService {
  final entrants = [
    {
      "id": "ENT01",
      "name": "Amanida mediterrània de prova",
      "description":
          "Enciam, tomàquet, cogombre, olives, formatge feta i vinagreta.",
      "tipus": "amanides",
      "allergens": ["Llet"],
      "price": 9,
      "calories": 220,
      "dietType": ["Sense gluten", "Vegetarià"],
      "additionalInfo": "Fresca i lleugera.",
      "img": "img/amanida_mediterrania.png"
    },
    {
      "id": "ENT02",
      "name": "Amanida de quinoa i verdures de prova",
      "description": "Quinoa, espinacs, pebrot, ceba morada i alvocat.",
      "tipus": "amanides",
      "allergens": [],
      "price": 8.5,
      "calories": 300,
      "dietType": ["Vegà", "Sense gluten"],
      "additionalInfo": "Una opció nutritiva i lleugera.",
      "img": "img/amanida_quinoa_verdures.png"
    }
  ];

  @override
  Future<List<Map<String, dynamic>>> llegirProductes() async {
    return List<Map<String, dynamic>>.from(entrants);
  }
}
