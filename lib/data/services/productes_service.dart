

//creada en este paso 4
// éste es el contrato que los servicios implementan (api, fitxer, test, otro)

abstract class ProductesService {
  Future<List<Map<String, dynamic>>> llegirProductes();
}