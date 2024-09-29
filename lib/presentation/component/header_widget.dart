import 'package:flutter/material.dart';
import 'package:learn_bloc_todo_app/domain/modul/todo.dart';

class HeaderWidget extends StatelessWidget {
  final List<Todo> todos;
  const HeaderWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    //filter for fetch todo length value of new todo
    final newTodo = todos
        .where(
          (todo) => todo.isCompleted == false,
        )
        .toList();
    //filter for fetch todo length value of finished todo
    final finishedTodo = todos.where(
      (todo) => todo.isCompleted == true,
    );
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.1,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListTile(
              title: const Text(
                'To-Do',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                newTodo.length.toString(),
                style: const TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const VerticalDivider(),
          Flexible(
            child: ListTile(
              title: const Text(
                'Finished',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                finishedTodo.length.toString(),
                style: const TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
