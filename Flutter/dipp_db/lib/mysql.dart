import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '192.168.1.15',// nastavení přístupu do použité testovací databáze
      user = 'root',
      db = 'test';
  static int port = 3306;
  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        db: db
    );
    return await MySqlConnection.connect(settings);
  }
}

class EntryDB{  //třída reprezentující hodnoty v DB
  EntryDB({
    required this.id,
    required this.name,
  });
  String id;
  String name;

  @override
  String toString() {
    return 'EntryDB{id: $id, name: $name}';
  }
}