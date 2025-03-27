import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class BlogLocalDataSource {
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs});
  Future<List<BlogModel>> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Database database;

  BlogLocalDataSourceImpl(this.database);

  @override
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs}) async {
    await database.delete('blogs');

    for (final blog in blogs) {
      await database.insert(
        'blogs',
        blog.toLocalJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<BlogModel>> loadBlogs() async {
    final result = await database.query('blogs');

    return result.map((json) => BlogModel.fromLocalJson(json)).toList();
  }
}

Future<Database> initDB() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, 'blogs.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE blogs (
          id TEXT PRIMARY KEY,
          poster_id TEXT NOT NULL,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          image_url TEXT NOT NULL,
          topics TEXT NOT NULL, 
          updated_at TEXT NOT NULL,
          poster_name TEXT
        )
      ''');
    },
  );
}
