import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDB {
  static final CartDB _instance = CartDB._internal();
  static Database? _database;

  CartDB._internal();

  factory CartDB() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_usuario TEXT NOT NULL,
            id_evento TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertItem(String userId, String eventId) async {
    final db = await database;
    await db.insert('cart', {'id_usuario': userId, 'id_evento': eventId});
  }

  Future<void> removeItem(String userId, String eventId) async {
    final db = await database;
    await db.delete('cart', where: 'id_usuario = ? AND id_evento = ?', whereArgs: [userId, eventId]);
  }

  Future<List<String>> getUserCart(String userId) async {
    final db = await database;
    final result = await db.query('cart', where: 'id_usuario = ?', whereArgs: [userId]);
    return result.map((item) => item['id_evento'] as String).toList();
  }
}