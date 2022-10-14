import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:conflux/episodeCard.dart';

class EpisodeList extends StatefulWidget {
  const EpisodeList({Key? key}) : super(key: key);

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.movie),
            onPressed: _showSeriesList,
            tooltip: 'Saved Series',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final suggestion = _suggestions[index];
          final selected = _saved.contains(suggestion);

          handleSelect() {
            setState(() {
              if (selected) {
                _saved.remove(suggestion);
              } else {
                _saved.add(suggestion);
              }
            });
          }

          handleTap() {
            _showEpisodeDetails();
          }

          return EpisodeCard(title: suggestion.asPascalCase, selected: selected, handleSelect: handleSelect, handleTap: handleTap, );
        },
      ),
    );
  }


  // Navigates to saved route
  void _showSeriesList() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map((pair) {
            return ListTile(title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18)));
          });

          final widgets = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Manage Series')
            ),
            body: ListView(children: widgets),
          );
        },
      )
    );
  }

  // Navigates to episode route
  void _showEpisodeDetails() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Episode')),
            body: const Center(child: Text('Display episode details here')),
          );
        },
      )
    );
  }
}
