import 'dart:async';

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../dao/todoDao.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  final _todoController = TextEditingController();
  final _runFilterController = TextEditingController();
  final todoDao = TodoDao();

  List<Todo> todos = [];
  List<Todo> _foundToDo = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  @override
  void dispose() {
    _todoController.dispose();
    _runFilterController.dispose();
    super.dispose();
  }

  Future<void> loadTodos() async {
    setState(() => isLoading = true);
    //DB에서 투두 목록 불러오기
    todos = await todoDao.getTodos();
    _foundToDo = todos;
    setState(() => isLoading = false);
  }

  void _addToDoItem(String todoText) async {
    if (todoText.isEmpty) return;
    final newTodo = Todo(todoText: todoText.trim());
    await todoDao.insert(newTodo);
    await loadTodos();

    _todoController.clear();
    _runFilterController.clear();
  }

  void _deleteToDoItem(int id) async {
    await todoDao.delete(id);
    await loadTodos();
    _runFilterController.clear();
  }

  void _handleToDoChange(Todo todo) async {
    final updatedTodo = todo.copyWith(isDone: !todo.isDone);
    await todoDao.update(updatedTodo);
    await loadTodos();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results;
    if (enteredKeyword.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where(
            (todo) => todo.todoText!.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });

  }
  void _editToDoItem(Todo todo) {
    // 예: 텍스트 입력 대화상자 열기
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: todo.todoText);
        return AlertDialog(
          title: Text('다시 쓰는 투두'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: null,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newText = controller.text.trim();
                if (newText.isNotEmpty && newText != todo.todoText) {
                  final updatedTodo = todo.copyWith(todoText: newText);
                  await todoDao.update(updatedTodo);
                  await loadTodos();
                }
                Navigator.pop(context);
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: tdBGColor,
        // appBar: _buildAppBar(),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              '투두목록',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          isLoading
                              ? Center(child: CircularProgressIndicator())
                              : _foundToDo.isEmpty
                              ? Text('투두가 없어요!')
                              : Column(
                                  children: [
                                    for (Todo todo in _foundToDo.reversed)
                                      ToDoItem(
                                        todo: todo,
                                        onToDoChanged: _handleToDoChange,
                                        onDeleteItem: _deleteToDoItem,
                                        onEditItem: _editToDoItem,
                                      ),
                                    SizedBox(
                                      height: 70,
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                            hintText: '새로운 투두를 추가해보세요.',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _addToDoItem(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                          minimumSize: Size(60, 60),
                          backgroundColor: tdBlue,
                          elevation: 10,
                        ),
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _runFilterController,
        onChanged: _runFilter,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: '찾고 싶은 투두를 입력하세요!',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/test.png'),
            ),
          ),
        ],
      ),
    );
  }
}
