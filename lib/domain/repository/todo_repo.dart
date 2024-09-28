import 'package:learn_bloc_todo_app/domain/modul/todo.dart';

//Here you can define what the app can do
abstract class TodoRepo {
  //get list of todo
  Future<List<Todo>> getTodos();

  //add new todo
  Future<void> addTodo(Todo newTodo);

  //update an existing todo
  Future<void> updateTodo(Todo todo);

  //delete existing todo
  Future<void> deleteTodo(Todo todo);
}
