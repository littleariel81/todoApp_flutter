# 📝 Flutter To-Do App

## 📘 Overview
This project is a simple **To-Do List Application** built with **Flutter (Dart)**.  
It was developed to practice **state management**, **UI layout**, and **data persistence** in Flutter.

The app allows users to **add, edit, delete, and manage tasks** efficiently through a clean and intuitive interface.

---

## 🚀 Features
- Add, edit, and delete tasks
- Mark tasks as completed or pending
- Simple and clean user interface
- Local data storage support (optional with `shared_preferences` or similar)
- Cross-platform support (Android / iOS)

---

## 🛠 Tech Stack
| Category | Technology |
|----------|------------|
| Language | Dart |
| Framework | Flutter |
| IDE | Android Studio / IntelliJ Community |
| Version Control | Git, GitHub |

---

## 📂 Project Structure
```text
lib/
├── main.dart
├── model/
│   └── todo.dart
├── screens/
│   └── home.dart
├── widgets/
│   └── todo_item.dart
├── utils/
│   └── secure_storage.dart
├── constants/
│   └── colors.dart
├── dao/
│   └── todoDao.dart
├── data/
│   └── db_helper.dart
├── service/
│   └── todo_service.dart
└── storage_helper.dart
```

## 🔮 Future Improvements
- Add due dates and task reminders
- Add filtering and sorting options
- Sync with cloud storage (Firebase or Supabase)
- Apply advanced state management (Provider, Riverpod, or Bloc)
- Support for dark mode and responsive design