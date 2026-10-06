import 'dart:convert';
import 'dart:io';
import 'package:productes_cli/domain/entities/entrant.dart';

class ProductesRepository {
  Future<List<Entrant>> obtenirProductes() async {
    //al añair el Future '<>'abraza tmbién el List

    // await Future<void>.delayed(Duration(seconds: 2)); // pra al prubea al simular la carga
    final contingut = await File('data/entrants.json')
        .readAsString(); //al añadir el 'await' no es necesario el sync en readAsStringSyn
    final dades = jsonDecode(contingut);
    final llistaEntrants = (dades as List)  // dades se lee como List; cada Map de esa lista se transforma
        .map((element) => Entrant.fromJson(element as Map<String, dynamic>)).toList();    
                  // con "Entrant.fromJson(element as Map<String, dynamic>)" en un objeto Entrant, y a una lsita
                  // de objetos 'Entrant' guardad en 'llistaEntrants'

    return llistaEntrants;

    //throw UnimplementedError();
    //lo dewjo de momento por si acaso
  }
}


