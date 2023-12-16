import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  bool captured;

  Pokemon({required this.id, required this.name, required this.imageUrl, this.captured = false});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}

class TelaCaptura extends StatefulWidget {
  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  List<Pokemon> _pokemons = [];
  bool _isLoading = false;
  bool _hasInternet = false;

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  Future<void> _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _hasInternet = connectivityResult != ConnectivityResult.none;
    });

    if (_hasInternet) {
      _fetchPokemons();
    }
  }

  Future<void> _fetchPokemons() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1018'));
      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body)['results'];

        // Sorteia 6 números únicos de 0 a 1017
        final random = Random();
        Set<int> selectedIndices = {};
        while (selectedIndices.length < 6) {
          selectedIndices.add(random.nextInt(1018));
        }

        // Obtém dados dos Pokémon sorteados
        List<Pokemon> selectedPokemons = [];
        for (var index in selectedIndices) {
          final pokemonUrl = results[index]['url'];
          final pokemonResponse = await http.get(Uri.parse(pokemonUrl));
          final pokemonData = jsonDecode(pokemonResponse.body);
          selectedPokemons.add(Pokemon.fromJson(pokemonData));
        }

        setState(() {
          _pokemons = selectedPokemons;
        });
      } else {
        throw Exception('Failed to load pokemons');
      }
    } catch (e) {
      // Handle error
      print('Error loading pokemons: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Captura'),
      ),
      body: _hasInternet
          ? _isLoading
              ? Center(child: CircularProgressIndicator())
              : _buildPokemonListView()
          : Center(
              child: Text('Sem conexão com a internet. Por favor, verifique sua conexão.'),
            ),
    );
  }

  Widget _buildPokemonListView() {
    return ListView.builder(
      itemCount: _pokemons.length,
      itemBuilder: (context, index) {
        return PokemonItem(pokemon: _pokemons[index]);
      },
    );
  }
}

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  PokemonItem({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            pokemon.imageUrl,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${pokemon.id}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Name: ${pokemon.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: pokemon.captured ? null : () => _capturePokemon(context),
                  child: Text(pokemon.captured ? 'Capturado' : 'Capturar'),
                  style: ElevatedButton.styleFrom(
                    primary: pokemon.captured ? Colors.grey : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _capturePokemon(BuildContext context) {
    // Lógica para capturar o Pokémon (pode adicionar aqui)
    // Exemplo: setState(() => pokemon.captured = true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Você capturou ${pokemon.name}!'),
    ));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaCaptura(),
    );
  }
}
