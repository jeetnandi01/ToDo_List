📝 To-Do Application (Flutter + Hive)

A **feature-rich To-Do List App** built using **Flutter** and **Hive** for offline data storage.  
This project demonstrates **clean architecture, local database handling, and user-friendly task management**.

---

## 📌 Project Overview
The app helps users efficiently manage daily tasks with features like **priority levels, categories, statistics, and CRUD operations**.  
Tasks are stored locally using **Hive**, ensuring offline-first experience.

---

## 🚀 Features
- 📊 **Task Statistics**
  - Total tasks count  
  - Pending tasks count  
  - Completed tasks count  
- ✅ Add, edit, and delete tasks  
- 📅 Add task details:  
  - Title  
  - Description  
  - Date & Time  
  - Priority (High, Medium, Low)  
  - Category (Work, Personal, Shopping, etc.)  
- 🗂️ Task categorization for better organization  
- 🔔 Separate AppBars for **pending tasks** and **completed tasks**  
- 💾 Local persistent storage with **Hive**  
- 🎨 Clean, responsive, and user-friendly UI  

---

## 🛠️ Tools & Technologies
- **Framework:** Flutter (Dart)  
- **Database:** Hive (Lightweight, NoSQL, Offline-first)  
- **State Management:** Provider (or Riverpod/Bloc if used)  
- **UI:** Material Design Widgets  

---

## 📂 Project Structure

lib/ ┣ models/          # Task model (Hive adapter) ┣ screens/         # Home, Add Task, Task Details, Completed Tasks ┣ widgets/         # Reusable components (task card, buttons, app bars) ┣ services/        # Hive database services ┗ main.dart        # App entry point

---

## 📸 Screenshots
(Add screenshots of key screens with short explanations)  

- **Home Screen (Task List + Stats)**  
  ![Home Screenshot](screenshot_home.png)  

- **Add Task Screen (title, description, priority, category, date/time)**  
  ![Add Task Screenshot](screenshot_add.png)  

- **Completed Tasks Screen**  
  ![Completed Screenshot](screenshot_completed.png)  

---

## ⚙️ Installation & Setup
```bash
# Clone the repo
git clone https://github.com/your-username/todo-app-hive.git

# Navigate into the folder
cd todo-app-hive

# Install dependencies
flutter pub get

# Run the app
flutter run


---

🗄️ Hive Database

Each task is stored as an object in a Hive box.

Data persists locally on the device.

Adapters are generated for object serialization.


Example Task Model:

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  String priority; // High, Medium, Low

  @HiveField(4)
  String category; // Work, Personal, Shopping...

  @HiveField(5)
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.category,
    this.isCompleted = false,
  });
}


---

🎯 Learning Goals

This project helped me practice:

✅ Implementing CRUD operations with Hive

✅ Designing task statistics & filters

✅ Applying Provider for state management

✅ Structuring a scalable Flutter app

✅ Building responsive and clean UI



---

📈 Future Improvements

🔔 Push notifications for task reminders

🌓 Dark mode support

☁️ Cloud sync with Firebase/Backend

📊 Dashboard with charts for task analytics

👥 User authentication for multi-user support



---

🤝 Contributing

Contributions are welcome! Fork the repo and submit a PR 🚀


---

📄 License

This project is licensed under the MIT License.

---

👉 This README will make your **simple To-Do app look professional & production-like**.  

Do you want me to also **add a “Project Demo” section with GIF (screen recording of app usage)** so interviewers can quickly see it in action without running code?