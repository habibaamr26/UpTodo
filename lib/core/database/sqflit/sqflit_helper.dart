import 'package:sqflite/sqflite.dart';

import '../../../features/task/data/model/task_model.dart';

class LocalDataBase {
    Database? db;

// create database and table
  void createDatabase() async {
    await openDatabase(
      "Tasks.db",
      version: 1,
      onCreate: (Database db, version) async {
        return await db
            .execute(
                'CREATE TABLE task (  id INTEGER PRIMARY KEY ,title TEXT,note TEXT,date TEXT,startTime TEXT,endTime TEXT,color INTEGER,isCompleted INTEGER )')
            .then((value) {
        }).onError((error, stackTrace) {
            print(error);
        });
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value);
  }

  //insert data
  Future<int> insertData({
    required TaskModel model,
  }) async {
    return await db!.rawInsert('''
     INSERT INTO task(
      title ,note ,date ,startTime ,endTime ,color ,isCompleted )
  VALUES
  ('${model.title}','${model.note}','${model.date}','${model.startTime}',
  '${model.endTime}','${model.color}','${model.isCompleted}')''');
  }

//get data

  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db!.rawQuery('SELECT * FROM task');
  }

// delete data

  Future<int> deleteData(id) async {
    return await db!.rawDelete(
      '''DELETE FROM task WHERE id = ?''',
      [id],
    );
  }

//update data

  Future<int> updateData({required int id}) async {
    return await db!.rawUpdate('''
    UPDATE task
    SET isCompleted = ?
    WHERE id = ?
   ''', [1, id]);
  }
}
