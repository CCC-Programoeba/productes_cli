import 'data/repositories/productes_repository.dart';
import 'domain/entities/entrant.dart';
//import 'dart:convert';        ya no hace falta al ser trabajo del repositorio
//import 'dart:io';             ya no hace falta al ser trabajo del repositorio

// estams en Pràctica 02
class App {

  List<Entrant> llistaEntrants = []; // Iniciada vacía
  final repository = ProductesRepository();   // Iniciada una instancia

  /*void carregar() {
    final contingut = File('data/entrants.json')
        .readAsStringSync(); //'contingut' es una var final tipo String que contiene entrants.json leído como string.
    final dades = jsonDecode(
        contingut); //convierte el string de contingut a algo legible, lo 'traduce' para que dart lo entiuenda
    llistaEntrants = (dades
            as List) // dades se lee como List; cada Map de esa lista se transforma
        // con "Entrant.fromJson(element as Map<String, dynamic>)" en un objeto Entrant
        .map((element) => Entrant.fromJson(element as Map<String, dynamic>))
        .toList();
    //throw UnimplementedError("P1: lectura i creació d’entitats");
  }*/

  Future <void> carregar() async { //Pràctica 02    ahora void va entre <> porque...si
    llistaEntrants = await repository.obtenirProductes();   //se espera a que llegue la respuesta
  }

  void mostrarLlistaProductes() {
    // 'list'
    for (final entrant in llistaEntrants) {
      print('${entrant.id}: ${entrant.name}');
    }
  }

  void mostrarInfoProducte(String id) {
    // 'show ENTXX'
    for (final entrant in llistaEntrants) {
      if (entrant.id == id) {
        print('${entrant.name}\n${entrant.description}');
        print('Tipus: ${entrant.tipus ?? "Sense especificar"}');
        print('Al·lèrgens: ${entrant.allergens.join(", ")}');
        print('Preu: ${entrant.price.toStringAsFixed(2)} €');
        /*en entrant.dart pusimos que price: (json['price'] as num).toDouble(), convertimos el
         nº que fuera a Double igualmente, y ahora a String de 2 digitos tras lña '.'*/
        print('Calories: ${entrant.calories}');
        print('Dietes: ${entrant.dietType?.join(", ") ?? "Sense especificar"}');
        print('Informació: ${entrant.additionalInfo ?? "-"}');
        print('Imatge: ${entrant.img ?? "-"}');
        return;
      }
    }
    print('No s’ha trobat cap producte amb ID $id');
  }
}
