import 'package:dipp_db/form.dart';
import 'package:dipp_db/mysql.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<List<EntryDB>> _getDBData() async {
  var db = Mysql();
  final List<EntryDB> myList = []; //list pro výsledky
  String sql = 'select id, name from mobile'; //stanovení SQL příkazu

  await db.getConnection().then((conn) async {  //asynchronní připojení a následné vyvolání požadavku na DB
    await conn.query(sql).then((results) {
      for (var row in results) {  //transformace získaných dat do připraveného listu
        final EntryDB entry = EntryDB(id: row[0].toString(), name: row[1].toString());
        myList.add(entry);
      }
    }).onError((error, stackTrace) {
      print(error);
      return null;
    });
    conn.close();
  });
  return myList;
}

class _MyHomePageState extends State<MyHomePage> {
  var db = Mysql();

  showFutureDBData() {
    return FutureBuilder<List<EntryDB>>(
      future: _getDBData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {  //kontrola připojení k DB
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
                  () {
                setState(() {});
              },);
          },
          child: ListView.builder(  //vykreslování výsledků
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final entry = snapshot.data![index];
              return ListTile(
                leading: Text(entry.id),
                title: Text(entry.name),
                onLongPress: () => onDeleteEntry(entry, context),
              );
            },),
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: showFutureDBData(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addToDB(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  onDeleteEntry(EntryDB entry, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text("Bude smazán záznam s id: ${entry.id} a hodnotou: ${entry.name}"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Zrušit")),
              ElevatedButton(
                  onPressed: () async {
                    await db.getConnection().then((conn) async {
                      await conn.query('delete from mobile where id=?', [entry.id]);
                    });
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok")),

            ],
          );
        }
    );
  }

  _addToDB() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyFormPage())).then((_) {
      setState(() {});
    });
  }

}
