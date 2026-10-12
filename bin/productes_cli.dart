import 'dart:io';
import 'package:productes_cli/productes_cli.dart';  //ésto es válido gracias a la buena nomenclatura en el pubspec.yaml

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

/**
 * Recorregut complet d'una consulta HTTP fins a la pantalla:
 * 
 * La HTTP empieza en App, que pide los productos a ProductesRepository. 
 * ProductesRepository llama a ApiService.llegirProductes(). 
 * ApiService hace una petición GET con http.Client, que recibe la respuesta en bytes y la convierte a texto mediante UTF-8.
 * Después jsonDecode transforma el JSON en una lista de mapas.
 * El repositorio recibe esos mapas y utiliza mapEntrant para convertir cada uno en un objeto Entrant.
 * Finalmente, App guarda la lista de Entrant y la muestra por pantalla.
 */

/**Capturas de pantalla guardadas de momento de los distintos errrores con los fallos
 * deliberados en la URL
 */

/**Expliqueu quina classe encara decideix l'origen i per què voldríem prendre aquesta decisió des del programa principa
 * 
 * class ProductesRepository es ahora la encargada de decidir (si comentamos/descomentamos una linea u otra)
 * Seria preferible hacerlo desde un menu principal y que el user elija el origen
 * 
 */