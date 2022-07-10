import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board Games',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Board Games'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _baseUrl = 'https://api.boardgameatlas.com/api/search';
  final _clientId = 'K2lnAg74ff';
  String _searchedName = 'Catan';

  int _skip = 0;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _games = [];
  late ScrollController _controller;

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(Uri.parse("$_baseUrl?client_id=$_clientId&skip=$_skip&limit=$_limit&name=$_searchedName"));  //volání API
      setState(() {
        Map<String, dynamic> map = json.decode(res.body);
        _games = map["games"];
      });
    } catch (err) {
      print('Something went wrong in first load');
      print(err);
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _skip += _limit; // Increase _page by 1
      try {
        final res = await http.get(Uri.parse("$_baseUrl?client_id=$_clientId&skip=$_skip&limit=$_limit&name=$_searchedName"));
        Map<String, dynamic> map = json.decode(res.body);
        final List fetchedPosts = map["games"];
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _games.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong when loading more!');
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore); //nastavení controlleru pro ListVire
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            final String selected = await showSearch(
                context: context,
                delegate: MySearchDelegate(),
            ) as String;
            if(selected.isNotEmpty){
              onSearchSubmitted(selected);
            }
          },
        ),]
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: _isFirstLoadRunning
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(  //zobrazováí výsledných hodnot
              controller: _controller,
              itemCount: _games.length,
              itemBuilder: (_, index) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  leading: SizedBox(
                    child: Image.network(_games[index]['thumb_url']),
                    width: 48,
                  ),
                  title: Text(_games[index]['name']),
                  subtitle: Text(_games[index]['price']),
                ),
              ),
            ),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_hasNextPage == false)
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: const Center(
                child: Text('You have fetched all of the content'),
              ),
            ),
        ],
      ),
    );
  }

  void onSearchSubmitted(String value) {  //metoda volající se po potvrzení vyhledávání
    final stopwatch = Stopwatch()..start();
    setState(() {
      _searchedName = value;
    });
    _firstLoad();
    print('doSomething() executed in ${stopwatch.elapsed}');
  }
}

class MySearchDelegate extends SearchDelegate { //přednastavení stránky s vyhledávacím polem
  @override
  List<Widget>? buildActions(BuildContext context) =>[
    IconButton(
     icon: const Icon(Icons.clear),
     onPressed: () {
       if(query.isEmpty){
         close(context, null);
       }else{
         query = '';
       }
     },
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );


  @override
  Widget buildResults(BuildContext context) {//odeslání výsledků zpět na hlavní stranu po stisknutí potvrzení
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                close(context, query);
              },
              child: Text(query),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
