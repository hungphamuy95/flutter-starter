import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup New Generator',
        theme: ThemeData(primaryColor: Colors.pink),
        home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  void _pushSaved() {
    if (_saved.length == 0) {
      _showDialog();
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (BuildContext context) {
        final Iterable<ListTile> titles = _saved.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final List<Widget> divided =
            ListTile.divideTiles(context: context, tiles: titles).toList();
        return Scaffold(
            appBar: AppBar(
              title: Text("Saved suggestion"),
            ),
            body: ListView(children: divided));
      }));
    }
  }

  void _clearSaved() {
    setState(() {
     _saved.clear(); 
    });
  }

  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Alert Dialog"),
          content: new Text("You must pick at least one item"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          IconButton(icon: Icon(Icons.clear), onPressed: _clearSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
