
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;

  Pokemon({required this.id, required this.name, required this.imageUrl});

  // Método de fábrica para criar uma instância de Pokemon a partir de dados JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
    );
  }

  // Método estático para buscar um Pokémon da API usando um ID
  static Future<Pokemon> fetchPokemon(int id) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
  static Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=2'));

    if (response.statusCode == 200) {
      final List<dynamic> results = jsonDecode(response.body)['results'];
      List<Pokemon> pokemons = [];

      for (var result in results) {
        final pokemonUrl = result['url'];
        final pokemonResponse = await http.get(Uri.parse(pokemonUrl));
        final pokemonData = jsonDecode(pokemonResponse.body);
        pokemons.add(Pokemon.fromJson(pokemonData));
      }

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

}









/**
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
//part 'api.g.dart';

@JsonSerializable()
class Pokemon {
  final int id;
  final String name;
  final String imageUrl;

  Pokemon({required this.id, required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);

  static Future<Pokemon> fetchPokemon(String id) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
} */