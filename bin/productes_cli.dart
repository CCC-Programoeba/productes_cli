import 'dart:io';
import 'package:productes_cli/data/services/test_service.dart';
import 'package:productes_cli/productes_cli.dart';
import 'package:productes_cli/data/repositories/productes_repository.dart';
import 'package:productes_cli/data/services/fitxer_service.dart';
import 'package:productes_cli/data/services/api_service.dart';
import 'package:productes_cli/data/services/productes_service.dart';

Future<void> main(List<String> arguments) async {
  final ordre = arguments.isEmpty ? '' : arguments.first;

  final valid = (ordre == 'list' &&
          (arguments.length == 1 || arguments.length == 2)) ||
      (ordre == 'show' &&
          (arguments.length == 2 || arguments.length == 3)); //leemos los args

  if (!valid) {
    print(
        'Ús: dart run bin/productes_cli.dart list [fitxer|api|test] | show ID [fitxer|api|test]');
    exitCode = 64;
    return;
  } //'pequeño help' en caso de no ser valido

  String font = 'fitxer'; //por default es fitxer

  if (ordre == 'list' && arguments.length == 2) {
    font = arguments[1];
  } //si es solo list, con un arg decimos si fitxer o api

  if (ordre == 'show' && arguments.length == 3) {
    font = arguments[
        2]; //si es show, 2 artgs, el entrant que queremos y si fitxer o api
  }

  if (font != 'fitxer' && font != 'api' && font != 'test') {
    //si  no es la de por defecto, ni la API,ni test peus error
    print('Font desconeguda: $font');
    exitCode = 64;
    return;
  }
  try {
    // aquí eliges ApiService o FitxerService usando font
    final ProductesService service;

    if (font == 'api') {
      service = ApiService(
        Uri.parse(
          'https://healthys-express-backend-production.up.railway.app/api/entrants',
        ),
      );
    } else if (font == 'test') {
      service = TestService();
    } else {
      service = FitxerService();
    }
    final repository =
        ProductesRepository(service); // inyecta el servicio en el repo
    final app = App(repository); // inyecta el repo en App
    await app.carregar(); //APP pide cargar los productos

    if (ordre == 'list') {
      app.mostrarLlistaProductes();
    } else {
      app.mostrarInfoProducte(arguments[1]);
    }
  } catch (error) {
    stderr.writeln('No s’han pogut carregar els productes: $error');
    exitCode = 1;
  }
}

/**
Al empezar
main 
  -> ProductesService (FitxerService / ApiService / TestService)
    ->ProductesRepository
      ->App

Al consultar, iniciando en App

App
->ProductesRepository
  ->ProductesService
    ->archivo / API / memoria
      ->List<Map<String, dynamic>>
        ->mapper
          ->List<Entrant>
            ->App
              ->pantalla
 */

/**
 * En què es diferencien servei, repositori i entitat?
 * 
 * Servicio
 *  El servicio obtiene los datos desde una fuente , como un fichero (JSON), una API o memoria.
 * Repositorio
 *  El repositorio utiliza el servicio y transforma los datos recibidos en entidades.
 * Entidad
 *  La entidad representa los datos del dominio, en este caso un producto Entrant * 
 * 
 */

/**Per què no retornem JSON a App?
 * 
 * Porque recibe directamente 
 * List<Entrant>
 * A App en ésta parte (y es mejor así) le llega la información como la necesita, 
 * sin que sepa (porque no lo nceesita) de donde viene (JSON, XML, CSV...; ya sea archivo local o ajena)
 * 
 */

/**Com afegiríeu una quarta font 
 * 
 * De la misma manera que hemos añadido ApiService o TestService:
 * creandoun nuevo servicio que implemente (implements ProducteService)
 * 
 */

/**Què caldria adaptar si el format de la quarta font fora diferent?
 *
 * Habría que adaptar el servicio que se ocupa de ello al mimso formato que los JSON en éste ejercico
 * List<Map<String, dynamic>>
 * Ya sea XML, CSV o cualquiera, debe convertirse a Una List para ProductesRepository
 * 
 */

/**Quina decisió hem traslladat del repositori a main i per què?
 * 
 * Al main hemos trasladado (en ésta parrte 4) la decisión de qué fuente usar.
 * Antes en el 3 ésa decisión la tomabamos en el ProductesRepository, comentando o descomentando según quisieramos un  origen u otro
 * Ahora el servicio nos da, independientementte de su origen, lo que necesitams para nuestro repositorio
 * 
 */