import 'package:flutter/material.dart';

class AnimatedSearch extends StatelessWidget {
  const AnimatedSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 149, 117, 205),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(
            'Buscar',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(6),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
