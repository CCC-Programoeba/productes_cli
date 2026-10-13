import 'package:http/http.dart' as http;
import 'package:productes_cli/data/services/productes_service.dart';
import 'dart:convert';

class ApiService implements ProductesService {
  final Uri uri;
  ApiService(this.uri); //constructor q no envia peticion
  @override
  Future<List<Map<String, dynamic>>> llegirProductes() async {
    final client = http.Client();

    try {
      final resposta = await client.get(uri).timeout(
          const Duration(seconds: 15)); //si tarda mas de 15 segs, hace el thrwo

      if (resposta.statusCode != 200) {
        throw http.ClientException("Error HTTP: ${resposta.statusCode}");
      }

      final text = utf8.decode(resposta.bodyBytes);
      final dades = jsonDecode(text);

      final llista = (dades as List)
          .map((element) => element as Map<String, dynamic>)
          .toList();

      return llista;
    } finally {
      client.close();
    }
  }
}
