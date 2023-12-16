import 'package:flutter/material.dart';

class PokeballButton extends StatelessWidget {
  final VoidCallback onPressed;

  PokeballButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.shade500,
          border: Border.all(color: Colors.white, width: 4.0),
        ),
        child: const Center(
          child: Icon(
            Icons.catching_pokemon,
            color: Colors.white,
            size: 70.0,
          ),
        ),
      ),
    );
  }
}
