---**📝 To-Do List**

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

lib/ 
┣ models/          # Task model (Hive adapter) 
┣ screens/         # Home, Add Task, Task Details, Completed Tasks 
┣ widgets/         # Reusable components (task card, buttons, app bars) 
┣ services/        # Hive database services 
┗ main.dart        # App entry point

---

## 📸 Screenshots
(Add screenshots of key screens with short explanations)  

- **Home Screen (Task List + Stats)**  
  ![Home Screenshot](screenshot_home.png)  

- **Add Task Screen (title, description, priority, category, date/time)**  
  ![Add Task Screenshot](screenshot_add.png)  

- **Completed Tasks Screen**  
  ![Completed Screenshot](screenshot_completed.png)  
