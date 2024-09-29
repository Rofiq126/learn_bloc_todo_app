/* 
TO DO CUBIT - simple state management
Each cubit is a list of todos.
*/

import 'package:bloc/bloc.dart';
import 'package:learn_bloc_todo_app/domain/modul/todo.dart';
import 'package:learn_bloc_todo_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  //Reference todo repo
  final TodoRepo todoRepo;

  //Contractor initialism the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //Load
  Future<void> loadTodos() async {
    //fetch list todos from repo
    final todoList = await todoRepo.getTodos();

    //emit the fetched list as the new state
    emit(todoList);
  }

  //Add
  Future<void> addTodo(String text) async {
    //create todo with unique id
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);

    //save new todo to repo
    await todoRepo.addTodo(newTodo);

    //re-load
    loadTodos();
  }

  //Update
  Future<void> updateTodo(String text, Todo todo) async {
    //initiate update todo
    final updatedTodo = Todo(id: todo.id, text: text);

    //save new updated todo
    await todoRepo.updateTodo(updatedTodo);

    //re-load
    loadTodos();
  }

  //Delete
  Future<void> deleteTodo(Todo todo) async {
    //delete the provided todo from repo
    await todoRepo.deleteTodo(todo);
    //re-load
    loadTodos();
  }

  //Toggle
  Future<void> toggleCompletion(Todo todo) async {
    //toggle to completion state of provided todo
    final updateTodo = todo.toggleComplete();

    //update the todo in repo with new complete status
    await todoRepo.updateTodo(updateTodo);

    //re-load
    loadTodos();
  }
}
