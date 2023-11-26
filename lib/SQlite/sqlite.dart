import 'package:cmms/jsonmodels/note_model.dart';
import 'package:cmms/jsonmodels/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  final databaseName = "note.db";
  String noteTable = "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT,noteTitle TEXT NOT NULL,noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  // now we must create our user Table into our sqlite db
  String users = "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT,usrName TEXT UNIQUE,usrPassword TEXT)";
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,databaseName);
   
    return openDatabase(path,version:1,onCreate: (db,version) async{
      await db.execute(users);
      await db.execute(noteTable);
      
      
      
    } );

   
  }

  //crud methods
  //create notes
  //get notes
  //delete notes
  //update notes
  Future<int> CreateNote(NoteModel note)async{
    final Database db = await initDB();
    return db.insert('notes', note.toMap());

  }
  Future<List<NoteModel>> getNotes() async{
    final Database db = await initDB();
    List<Map<String,Object?>> result = await db.query("notes");
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }
  Future<int> deleteNote(int id) async{
     final Database db = await initDB();
     return db.delete('notes',where:'noteId = ?',whereArgs:[id]);
  }
  Future<int> updateNote(title,content,noteId) async{
    final Database db = await initDB();
    return db.rawUpdate('update notes set noteTitle = ?, noteContent = ? where noteId = ?',
    [title,content,noteId]);
  }
  Future<bool> login(Users user) async{
    final Database db = await initDB();
    var result  =  await db.rawQuery(
      "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if(result.isNotEmpty){
      return true;
    }
    else {
      return false;
    }

  }
  Future<List<NoteModel>> getPass() async{
    final Database db = await initDB();
    List<Map<String,Object?>> result = await db.query("users");
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert("users",user.toMap());
    
}


}


    
  

  


