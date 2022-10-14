import 'package:flutter/material.dart';

/// Reusable Card component for each episode
class EpisodeCard extends StatelessWidget {
  // Constructor
  const EpisodeCard({
    super.key,
    required this.title,
    required this.selected,
    required this.handleSelect,
    required this.handleTap,
  });

  // Params
  final String title;
  final bool selected;
  final Function handleSelect;
  final Function handleTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: IconButton(
        icon: Icon(
            selected ? Icons.favorite : Icons.favorite_border,
            color: selected ? Colors.red : null,
            semanticLabel: selected ? 'Remove' : 'Add'
        ),
        onPressed: () {
          handleSelect();
        },
      ),
      onTap: () {
        handleTap();
      }
    );
  }
}
