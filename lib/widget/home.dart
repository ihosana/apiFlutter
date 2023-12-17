// PokemonCard(id: 1, name:"Rodrigo", imageUrl: "https://media-for1-1.cdn.whatsapp.net/v/t61.24694-24/328783713_539393664770074_2583058071233276838_n.jpg?ccb=11-4&oh=01_AdS9KIXCsrl4FpuyYsUhIEf-U175YP0Bm82PALe8Juq38Q&oe=6588635E&_nc_sid=e6ed6c&_nc_cat=106");
import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terceira_prova_pok/main.dart';
import 'package:terceira_prova_pok/model/api.dart';
import 'package:terceira_prova_pok/widget/Card.dart';

class TelaHome extends State<MyApp> with TickerProviderStateMixin {
  List<Pokemon> _pokemons = [];
  bool _isLoading = false;
  bool _hasInternet = false;
  late TabController _tabController;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 75, 160),
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            labelColor: Color.fromARGB(255, 250, 226, 12),
            tabs: const [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.catching_pokemon)),
              Tab(icon: Icon(Icons.people_rounded)),
            ],
          ),
          title: const Text('Pokemon'),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            const Icon(Icons.directions_car),
            Center(
                child: Column(
              children: [
                TextButton(
                  onPressed: () => _tabController.animateTo(0),
                  child: _connectionStatus != ConnectivityResult.none
                      ? test()
                      : Text('Sem conexão com a internet'),
                ),
              ],
            )),
            TelaSobre(),
          ],
        ),
      ),
    );
  }
}

class TelaSobre extends StatelessWidget {
  const TelaSobre({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Title(
                color: Colors.black,
                child: const Text("Pagina Sobre",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26))),
            Title(
                color: Colors.black,
                child: const Text("Desenvolvedores:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            const Padding(
                padding: EdgeInsets.only(right: 10, top: 40),
                child: Column(
                  children: [
                    Text("Ihosana de Assis,"),
                    Text("Rodrigo Pacheco,")
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class test extends StatelessWidget {
  const test({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Carrega os dados do Pokémon com ID 1
      future: Pokemon.fetchPokemon(1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibe um indicador de progresso enquanto os dados estão sendo carregados
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Exibe uma mensagem de erro se ocorrer um erro
          return Text("Não achado");
        } else {
          Pokemon pokemon = snapshot.data as Pokemon;
          return PokemonItem(pokemon: pokemon);
        }
      },
    );
  }
}
 /**
  * 

      
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Exibe um indicador de progresso enquanto os dados estão sendo carregados
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Exibe uma mensagem de erro se ocorrer um erro
                return Text("Não achado");
              } else {
                // Exibe o card do Pokémon quando os dados estiverem prontos
                Pokemon pokemon = snapshot.data as Pokemon;
                return PokemonCard(pokemon: pokemon);
              }
      theme: ThemeData(
      
       colorScheme:ColorScheme.fromSeed(background: const Color.fromARGB(66, 206, 38, 38), seedColor: const Color.fromARGB(255, 238, 130, 130)),
      useMaterial3: true, 
      ),*/








