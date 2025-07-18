# Tasks Manager

Tasks Manager is a simple and modern task management app built with Flutter. It allows users to register, log in, and manage their daily tasks efficiently.

## Features
- User registration and login (Firebase Authentication)
- Task list with add, edit, and delete functionality
- Responsive and clean UI

## Technologies Used
- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Firebase Auth & Firestore](https://firebase.google.com/)

## Project Structure
```
lib/
│   main.dart
│
├── screens
│   ├── login
│   │   ├── bloc
│   │   │   ├── login_bloc.dart
│   │   │   ├── login_event.dart
│   │   │   └── login_state.dart
│   │   └── view
│   │       ├── login_view.dart
│   │       └── widgets
│   │           ├── login_email_field.dart
│   │           ├── login_logo.dart
│   │           ├── login_password_field.dart
│   │           ├── login_submit_button.dart
│   │           └── login_title.dart
│   ├── register
│   │   ├── bloc
│   │   │   ├── register_bloc.dart
│   │   │   ├── register_event.dart
│   │   │   └── register_state.dart
│   │   └── view
│   │       ├── register_view.dart
│   │       └── widgets
│   │           ├── register_confirm_password_field.dart
│   │           ├── register_email_field.dart
│   │           ├── register_password_field.dart
│   │           ├── register_submit_button.dart
│   │           └── register_title.dart
│   ├── splash
│   │   ├── bloc
│   │   │   ├── splash_bloc.dart
│   │   │   ├── splash_event.dart
│   │   │   └── splash_state.dart
│   │   └── view
│   │       ├── splash_view.dart
│   │       └── widgets
│   │           ├── splash_logo.dart
│   │           └── splash_title.dart
│   └── tasks_list
│       ├── bloc
│       │   ├── categories_bloc.dart
│       │   ├── categories_event.dart
│       │   ├── categories_state.dart
│       │   ├── tasks_bloc.dart
│       │   ├── tasks_event.dart
│       │   └── tasks_state.dart
│       ├── model
│       │   ├── category_model.dart
│       │   └── task_model.dart
│       └── view
│           ├── category_manager_view.dart
│           ├── task_form_view.dart
│           ├── tasks_list_view.dart
│           └── widgets
│           │   ├── add_task_button.dart
│           │   ├── category_add_field.dart
│           │   ├── category_list_tile.dart
│           │   ├── logout_button.dart
│           │   ├── task_category_dropdown.dart
│           │   ├── task_description_field.dart
│           │   ├── task_due_date_tile.dart
│           │   ├── task_list_tile.dart
│           │   ├── task_save_button.dart
│           │   ├── task_status_dropdown.dart
│           │   ├── task_title_field.dart
│           │   └── tasks_filter_field.dart
│
└── theme
    app_theme.dart
assets/
└── logo
    └── logo_slogan.svg
```

## Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- [Git](https://git-scm.com/) installed
- A Firebase project (see below)

## Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Add an Android app to your Firebase project and download the `google-services.json` file.
3. Place the `google-services.json` file in the `android/app/` directory.
4. Enable **Authentication** (Email/Password) and **Cloud Firestore** in the Firebase Console.

## How to Run
Clone the repository and run the following command in the project root:

```powershell
flutter pub get; flutter run
```

This command will install all dependencies and launch the app on your connected device or emulator.

## Author

- **Pedro Figueiredo**
    - Email: pedro.pessoal1996@gmail.com
    - [GitHub](https://github.com/)
    - [LinkedIn](https://www.linkedin.com/in/pedro-figueiredo-15762713b/)
