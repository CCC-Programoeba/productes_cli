import 'data/repositories/productes_repository.dart';
import 'domain/entities/entrant.dart';
//import 'dart:convert';        ya no hace falta al ser trabajo del repositorio
//import 'dart:io';             ya no hace falta al ser trabajo del repositorio

// estamos en Pràctica 03
class App {

  List<Entrant> llistaEntrants = []; // Iniciada vacía
  final repository = ProductesRepository();   // Iniciada una instancia

  Future <void> carregar() async { 
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
