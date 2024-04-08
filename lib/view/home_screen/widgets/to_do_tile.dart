import 'package:flutter/material.dart';
import 'package:todo_app_clone/model/student_model.dart';

class ToDoTile extends StatelessWidget {
  const ToDoTile({
    super.key,
    required this.item,
    this.onDeletePressed,
    this.onCheckStateChanged,
  });

  final TaskModel item;
  final void Function()? onDeletePressed;
  final void Function(bool? value)? onCheckStateChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        selectedTileColor: Colors.grey.withOpacity(.4),
        selected: true,
        leading: Transform.scale(
          scale: 1.6,
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              value: item.isCompleted,
              onChanged: onCheckStateChanged),
        ),
        title: Row(
          children: [
            Text(
              item.text,
              style: TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  decoration:
                      item.isCompleted ? TextDecoration.lineThrough : null),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: item.isCompleted ? Colors.green : Colors.blueGrey),
              child: Text(
                item.isCompleted ? "completed" : "incomplete",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: onDeletePressed,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
