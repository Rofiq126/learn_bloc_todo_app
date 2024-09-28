/*
TO DO VIEW: responsible for UI

- use BlocBuilder
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_todo_app/domain/modul/todo.dart';
import 'package:learn_bloc_todo_app/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //todo cubit

  //showDialog for user to type
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: const Text('Add To-Do'),
              content: CupertinoTextFormFieldRow(
                placeholder: 'Type your todo',
                keyboardType: TextInputType.text,
                maxLines: null,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  onPressed: () => todoCubit
                      .addTodo(textController.text)
                      .then((_) => Navigator.of(context).pop()),
                  child: const Text('Add'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.text),
                  leading: CupertinoCheckbox(
                      value: todo.isCompleted,
                      onChanged: (value) => todoCubit.toggleCompletion(todo)),
                  trailing: IconButton(
                      onPressed: () => todoCubit.deleteTodo(todo),
                      icon: const Icon(CupertinoIcons.delete)),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
          onPressed: () => _showAddTodoBox(context)),
    );
  }
}
