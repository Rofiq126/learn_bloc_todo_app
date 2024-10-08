/*
ISAR TO DO MODEL

Converts todo model into isar todo model that we can store in our isar db
*/

import 'package:isar/isar.dart';
import 'package:learn_bloc_todo_app/domain/modul/todo.dart';
//to generate todo object, run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convert isar object -> pure todo object to use in app
  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  // convert pure todo object -> isar object to store in isar database
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
