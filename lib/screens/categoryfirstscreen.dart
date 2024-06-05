import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CategoryCard(
          icon: Icons.person_rounded,
          label: 'Personal',
        ),
        CategoryCard(
          icon: Icons.calendar_month_rounded,
          label: 'Birthday',
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 130,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.purple,
        gradient: LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
          begin: Alignment.centerRight,
          end: Alignment(-1.0, -1.0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 14, 0, 0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
