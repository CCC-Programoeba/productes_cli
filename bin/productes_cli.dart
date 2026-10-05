import 'dart:io';
import 'package:productes_cli/productes_cli.dart';

/// Valida l'ordre abans de carregar dades; els errors es mostren en la consola.
void main(List<String> arguments) {
  final ordre = arguments.isEmpty ? '' : arguments.first;
  final valid = (ordre == 'list' && arguments.length == 1) ||
      (ordre == 'show' && arguments.length == 2);
  if (!valid) {
    print('Ús: dart run bin/productes_cli.dart list | show ID');
    exitCode = 64;
    return;
  }
  try {
    final app = App();
    app.carregar();
    if (ordre == 'list') {
      app.mostrarLlistaProductes();
    } else {
      app.mostrarInfoProducte(arguments[1]);
    }
  } catch (error) {
    // No amaguen la fallada amb una llista buida: indiquem el problema.
    stderr.writeln('No s’han pogut carregar els productes: $error');
    exitCode = 1;
  }
}
