import 'dart:io';
import 'package:productes_cli/productes_cli.dart';

Future <void> main(List<String> arguments) async {    //Future <void>...async
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
    await app.carregar();     //aqui el wawait al haber cambiado el main a async, si quitamos de nuevo 'await', pese a haber await en las funciones a las que llama, el main se sigue ejecutando, ya llegarán los resultados de las demás funncieons
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
/**Entramos por bin/prpductes.dart
 * Si los args son validos, nos lleva a app, donde 
 * con 'carregar', mediante ProductesRepository, leemos el json y lo
 * convierto en una list de maps, de objetos 'Entrant'
 * Una vez cargado, ejectua el 'show' o el 'list', segun le hayamos dicho
 * 
 */