
import 'package:productes_cli/domain/entities/entrant.dart';
import 'package:productes_cli/data/mappers/entrant_mapper.dart';
import 'package:productes_cli/data/services/productes_service.dart';

class ProductesRepository {

  final ProductesService service;

  ProductesRepository(this.service);          //el construcotr que va rellenandno cadac objeto

  Future<List<Entrant>> obtenirProductes() async {
    final dades = await service.llegirProductes();

    final llistaEntrants = dades
        .map(mapEntrant)
        .toList();

    return llistaEntrants;
  }
}