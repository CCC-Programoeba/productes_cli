//import 'dart:convert';   ahoras olo importamos packages de dentro de nuestor propio proyecto
//import 'dart:io';
import 'package:productes_cli/domain/entities/entrant.dart';
import 'package:productes_cli/data/services/fitxer_service.dart';
import 'package:productes_cli/data/mappers/entrant_mapper.dart';
import 'package:productes_cli/data/services/api_service.dart'; //la API

class ProductesRepository {

  final fitxerService = FitxerService();

  Future<List<Entrant>> obtenirProductes() async {

/** Comentamos o descomentamos la linea siguiente. No es necesario aqui lo del enunciado
 * de poner el usarapi = true/false
 */

    //final dades = await fitxerService         //usando el fichero de dentro de neustras carpetas
    final dades = await apiService          //camviado a la API para la prueba
        .llegirProductes(); //llamada a llegirProductes de la calse fitxerServide

    final llistaEntrants = dades //cada map
        .map(mapEntrant) //lo mappea pasando entrnant_mapper.dart
        .toList(); //y me devuelve un Entrant a lalista de entrants

    return llistaEntrants;
  }

  final apiService = ApiService(Uri.parse('https://healthys-express-backend-production.up.railway.app/api/entrants'));

} /*ProductesRepository   > fitxerService.llegirProductes()   ->    List<Map<String, dynamic>>  ->  .map(mapEntrant)  ->  List<Entrant>*/
