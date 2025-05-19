import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/core/models/api_product_model/api_product_model.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  static Database? _db;

  factory DBService() => _instance;

  DBService._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'wishlist.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            image TEXT,
            price REAL,
            category TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> addToFavorites(ApiProductModel product) async {
    final db = await database;
    await db.insert('favorites', {
      'id': product.id,
      'title': product.title,
      'description': product.description,
      'image': product.image,
      'price': product.price,
      'category': product.category,
      'rating': product.rating?.rate ?? 0.0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromFavorites(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ApiProductModel>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorites');
    return result
        .map(
          (e) => ApiProductModel(
            id: e['id'] as int?,
            title: e['title'] as String?,
            description: e['description'] as String?,
            image: e['image'] as String?,
            price: (e['price'] as num?)?.toDouble(),
            category: e['category'] as String?,
            rating: Rating(rate: (e['rating'] as num?)?.toDouble()),
          ),
        )
        .toList();
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
