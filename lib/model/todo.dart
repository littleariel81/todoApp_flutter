class Todo {
  int? id;
  String? todoText;
  bool isDone;
  String createdAt;
  String updatedAt;

  Todo({
    this.id,
    this.todoText,
    this.isDone = false,
    String? createdAt,
    String? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  // DB에 저장할 때 Map 형태로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // JSON → 객체
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todoText: json['todoText'],
      isDone: json['isDone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // DB에서 불러올 때 객체 변환
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      todoText: map['todoText'],
      isDone: map['isDone'] == 1,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  //update 할 때 updatedAt만 갱신되도록
  Todo copyWith({int? id, String? todoText, bool? isDone, String? updatedAt}) {
    return Todo(
      id: id ?? this.id,
      todoText: todoText ?? this.todoText,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
