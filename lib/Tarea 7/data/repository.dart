import 'dart:convert';
import 'model/superhero_detail_response.dart';
import 'model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  static List<SuperheroDetailResponse>? _cachedHeroes;

  Future<SuperheroResponse?> fetchSuperheroInfo(String name) async {
    try {
      // Usamos el mirror de Akabab que es mucho más estable y no tiene bloqueos 403
      if (_cachedHeroes == null) {
        final response = await http.get(Uri.parse(
          "https://akabab.github.io/superhero-api/api/all.json"
        ));

        if (response.statusCode == 200) {
          List<dynamic> decodedJson = jsonDecode(response.body);
          _cachedHeroes = decodedJson.map((item) => SuperheroDetailResponse.fromJson(item)).toList();
        } else {
          return null;
        }
      }

      // Filtramos localmente por nombre
      final filteredResults = _cachedHeroes!.where((hero) => 
        hero.name.toLowerCase().contains(name.toLowerCase())
      ).toList();

      return SuperheroResponse(
        response: "success",
        result: filteredResults
      );
    } catch (e) {
      print("Error fetching heroes: $e");
      return null;
    }
  }
}