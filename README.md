# 🧾 To Do Application

---

## 📌 Table of Contents
- <a href="#overview">Overview</a>
- <a href="#Features">Features</a>
- <a href="#Tools_Technologies">Tools & Technologies</a
- <a href="#project-structure">project-structure</a>
- <a href="#Screenshot">Screenshot</a>
- <a href="#Task Model">Task Model</a>
- <a href="#Learning Goals">Learning Goals</a>
- <a href="#how-to-run-this-project">how-to-run-this-project</a>
- <a href="#Future Improvements">Future Improvements</a>

---
<h2><a class="anchor" id="overview"></a>Overview</h2>

*To-Do Application* built using *Flutter* and *Hive* for offline data storage.  
This project demonstrates *clean architecture, local database handling, and user-friendly task management*.
The app helps users efficiently manage daily tasks with features like *priority levels, categories, and CRUD operations*.  
Tasks are stored locally using *Hive*, ensuring offline-first experience.

---
<h2><a class="anchor" id="Features"></a>Features</h2>

- 📊 *Task Statistics*
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
- 🗂 Task categorization for better organization
- 🌓 Dark mode support
- 🔔 Separate AppBars for *pending tasks* and *completed tasks*  
- 💾 Local persistent storage with *Hive*  
- 🎨 Clean, responsive, and user-friendly UI 

---

<h2><a class="anchor" id="Tools_Technologies"></a>Tools & Technologies</h2>

- *Framework:* Flutter (Dart)  
- *Database:* Hive (Lightweight, NoSQL, Offline-first)  
- *State Management:* Provider
- *UI:* Material Design Widgets  
- GitHub

---
<h2><a class="anchor" id="project-structure"></a>Project Structure</h2>

![Project Structure](images/dashboard.png)

---
<h2><a class="anchor" id="Screenshot"></a>Screenshot</h2>

- *Home Screen (Task List + Stats)*  
  ![Home Screenshot](screenshot_home.png)  

- *Add Task Screen (title, description, priority, category, date/time)*  
  ![Add Task Screenshot](screenshot_add.png)  

- *Completed Tasks Screen*  
  ![Completed Screenshot](screenshot_completed.png)  

---
<h2><a class="anchor" id="Task Model"></a>Task Model</h2>

*Task Model:*
- Each task is stored as an object in a Hive box.
- Data persists locally on the device.
- Adapters are generated for object serialization.

*Example Task Model:*

                  import 'package:hive/hive.dart';
                  part 'task_model.g.dart';
                  
                  @HiveType(typeId: 0)
                  class TaskModel extends HiveObject {
                    @HiveField(0)
                    String title;
                  
                    @HiveField(1)
                    String description;
                  
                    @HiveField(2)
                    DateTime date;
                  
                    @HiveField(3)
                    String priority;
                  
                    @HiveField(4)
                    bool isDone;
                  
                    @HiveField(5)
                    String repeat;
                  
                    @HiveField(6)
                    String category;
                  
                    @HiveField(7)
                    int? startHour;
                    @HiveField(8)
                    int? startMinute;
                  
                    @HiveField(9)
                    int? endHour;
                    @HiveField(10)
                    int? endMinute;
                  
                    @HiveField(11)
                    bool isPinned;
                  
                    TaskModel({
                      required this.title,
                      required this.description,
                      required this.date,
                      required this.priority,
                      this.isDone = false,
                      this.repeat = 'None',
                      this.category = 'General',
                      this.startHour,
                      this.startMinute,
                      this.endHour,
                      this.endMinute,
                      this.isPinned = false,
                    });
                  }


---
<h2><a class="anchor" id="Learning Goals"></a>Learning Goals</h2>

- This project helped me practice:
  - ✅ Implementing CRUD operations with Hive
  - ✅ Designing task statistics & filters
  - ✅ Applying Provider for state management
  - ✅ Structuring a scalable Flutter app
  - ✅ Building responsive and clean UI

---
<h2><a class="anchor" id="how-to-run-this-project"></a>How to Run This Project</h2>

    - Clone the repository:
        bash
        - git clone gh repo clone jeetnandi01/ToDo_List
    
    - Navigate into the folder
       - cd todo-app
    
    - Install dependencies
        - flutter pub get
    
    - Run the app
        - flutter run

---
<h2><a class="anchor" id="Future Improvements"></a>Future Improvements</h2>

    - 🔔 Push notifications for task reminders
    - ☁ Cloud sync with Firebase/Backend
    - 📊 Dashboard with charts for task analytics
    - 👥 User authentication for multi-user support
---
