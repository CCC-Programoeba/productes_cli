import 'dart:convert';
import 'dart:io';

class FitxerService {   //llamado desde ->productes_repository.dart

  Future<List<Map<String, dynamic>>> llegirProductes() async {

    final contingut = await File('data/entrants.json').readAsString();

    final dades = jsonDecode(contingut);

    return (dades as List)
        .map((element) => element as Map<String, dynamic>)
        .toList();
  }
}