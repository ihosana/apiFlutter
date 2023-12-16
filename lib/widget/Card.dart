import 'package:flutter/material.dart';
import 'package:terceira_prova_pok/model/api.dart';
import 'package:terceira_prova_pok/widget/PokeBola.dart';
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
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID:'+(pokemon.id).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Nome: '+pokemon.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
             Padding(padding: EdgeInsets.only(top:0,left:280 ),
             child: Row(
               children: [ PokeballButton(onPressed: () {  },)],
             ),)
               // TextButton(onPressed:null, child:Icon(Icons.catching_pokemon_sharp))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
