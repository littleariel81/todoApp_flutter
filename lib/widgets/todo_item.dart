import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatefulWidget {
  final Todo todo;
  final onToDoChanged;
  final onDeleteItem;
  final onEditItem;

  const ToDoItem({
    super.key,
    required this.todo,
    this.onToDoChanged,
    this.onDeleteItem,
    this.onEditItem,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_isExpanded ? 30 : 20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
        tileColor: Colors.white,
        leading: Checkbox(
          value: widget.todo.isDone,
          activeColor: tdBlue,
          onChanged: (value) {
            widget.onToDoChanged(widget.todo);
          },
        ),
        title: GestureDetector(
          onTap: _toggleExpanded,
          child: Text(
            widget.todo.todoText!,
            maxLines: _isExpanded ? null : 3,
            overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: widget.todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationThickness: widget.todo.isDone ? 2.0 : 0,
            ),
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                icon: Icon(Icons.edit, size: 18, color: Colors.white),
                onPressed: () {
                  if (widget.onEditItem != null)
                    widget.onEditItem!(widget.todo);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.onDeleteItem(widget.todo.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
