# 📝 Flutter To-Do App

## 📘 개요
이 프로젝트는 **Flutter(Dart)** 로 제작한 간단한 **할 일(To-Do) 관리 애플리케이션**입니다.  
플러터의 **상태 관리**, **UI 레이아웃 구성**, 그리고 **데이터 저장 방식**을 학습하기 위해 개발되었습니다.  
간단한 기능 구현을 통해 플러터 앱 구조를 이해하고, 실제 동작하는 모바일 앱 형태로 완성하는 것을 목표로 했습니다.

---

## 🚀 주요 기능
- 할 일 추가 / 수정 / 삭제
- 완료 여부 표시 (체크 기능)
- 직관적이고 깔끔한 사용자 인터페이스(UI)
- 로컬 데이터 저장 기능 (`shared_preferences` 등)
- Android / iOS 동시 지원 (크로스플랫폼)

---

## 🛠 기술 스택

| 구분 | 사용 기술                      |
|------|----------------------------|
| 언어 | Dart                       |
| 프레임워크 | Flutter                    |
| IDE | Android Studio / IntelliJ Community |
| 버전 관리 | Git, GitHub                |

---

## 📂 프로젝트 구조
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


🔮 향후 개선 아이디어
- 마감일 설정 및 알림 기능 추가
- 할 일 정렬 / 필터 기능 추가
- Firebase 또는 Supabase 연동으로 클라우드 동기화
- Riverpod, Bloc, Provider 등 고급 상태 관리 적용
- 다크 모드 및 반응형 디자인 지원