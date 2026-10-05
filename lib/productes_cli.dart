// Els imports es faran servir en completar el TODO.
// ignore_for_file: unused_import
import 'domain/entities/entrant.dart';
import 'dart:convert';
import 'dart:io';

/// En aquesta primera versió, App encara assumeix la lectura del fitxer.
class App {
  List<Entrant> llistaEntrants = []; // Iniciada vacía

  void carregar() {
    final contingut = File('data/entrants.json')
        .readAsStringSync(); //'contingut' es una var final tipo String que contiene entrants.json leído como string.
    final dades = jsonDecode(
        contingut); //convierte el string de contingut a algo legible, lo 'traduce' para que dart lo entiuenda
    llistaEntrants = (dades
            as List) // El jsonDecode en dades rellena a llistaEntrants
        .map((element) => Entrant.fromJson(element as Map<
            String, // .map() transforma cada Map en un entrant
            dynamic>)) // 'mappea' el json, lo traduce ya a algo legible para si mismo, por tanto ya entiende que el primer elementeo json es Entran 01, el 2º el 02, y etc
        // y => Entrant.fromJson(etc...) es POR CADA element, sacame un Entrant con los datos .fromJson
        .toList();

    //throw UnimplementedError("P1: lectura i creació d’entitats");
  }

  /// La consola decideix el format; l'entitat no conté colors ni print.
  void mostrarLlistaProductes() {
    // 'list'
    for (final entrant in llistaEntrants) {
      print('${entrant.id}: ${entrant.name}');
    }
  }

  /// Cerquem per identificador sense confondre'l amb la posició en la llista.
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

// ¿Qué sabe todavía App sobre el archivo?
// App ha creado en llistaEntrants todo del archivo, para no consuktarlo a cada vez

// Si cambiamos el origen de los datos, qué clase habría que modificar?
// class App, la funcion carregar
