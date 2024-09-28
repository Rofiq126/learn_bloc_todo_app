/*
DATABASE REPO

This implements the todo repo and handles storing, retrieving, updating, deleting in the isar database
*/

import 'package:isar/isar.dart';
import 'package:learn_bloc_todo_app/data/moduls/isar_todo.dart';
import 'package:learn_bloc_todo_app/domain/modul/todo.dart';
import 'package:learn_bloc_todo_app/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  //database
  final Isar db;

  IsarTodoRepo(this.db);

  //get Todo
  @override
  Future<List<Todo>> getTodos() async {
    //fetch from db
    final todos = await db.todoIsars.where().findAll();

    //return as llist of todos and give to domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  //add Todo
  @override
  Future<void> addTodo(Todo newTodo) {
    //covert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    //store to isar database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  //update Todo
  @override
  Future<void> updateTodo(Todo todo) {
    //covert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);

    //store to isar database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  //delete Todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
