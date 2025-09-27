import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  final void Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onThemeChanged,
    this.isDarkMode = false,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>('tasks');
  int _selectedIndex = 0;

  String _priorityFilter = 'All';
  String _categoryFilter = 'All';

  @override
  void initState() {
    super.initState();
    _processRecurringTasks();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // reset filters when switching tab if you like:
      // _priorityFilter = 'All';
      // _categoryFilter = 'All';
    });
  }

  Future<void> _navigateToAddTask({TaskModel? taskToEdit}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(
          taskToEdit: taskToEdit,
          isDarkMode: widget.isDarkMode,
        ),
      ),
    );
    if (result != null) {
      if (result is TaskModel) {
        await taskBox.add(result);
      }
      setState(() {});
    }
  }

  void _deleteTask(TaskModel task) async {
    await task.delete();
    setState(() {});
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Task deleted")));
  }

  Future<void> _deleteAllCompleted() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete All Completed Tasks"),
        content:
            const Text("Are you sure you want to delete all completed tasks?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final completed = taskBox.values.where((t) => t.isDone).toList();
      for (var t in completed) {
        await t.delete();
      }
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completed tasks deleted")),
      );
    }
  }

  void _processRecurringTasks() {
    final now = DateTime.now();
    for (var task in taskBox.values) {
      if (!task.isDone && task.repeat != 'None') {
        if (task.date.isBefore(now)) {
          switch (task.repeat) {
            case 'Daily':
              task.date = task.date.add(const Duration(days: 1));
              break;
            case 'Weekly':
              task.date = task.date.add(const Duration(days: 7));
              break;
            case 'Monthly':
              task.date =
                  DateTime(task.date.year, task.date.month + 1, task.date.day);
              break;
            default:
              break;
          }
          task.save();
        }
      }
    }
  }

  List<TaskModel> _getFilteredTasks({required bool completed}) {
    var list = taskBox.values.where((t) => t.isDone == completed).toList();

    if (_priorityFilter != 'All') {
      list = list.where((t) => t.priority == _priorityFilter).toList();
    }
    if (_categoryFilter != 'All') {
      list = list.where((t) => t.category == _categoryFilter).toList();
    }

    // Pinned first
    list.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.date.compareTo(b.date);
    });

    return list;
  }

  Widget _buildTasksTab() {
    final pending = _getFilteredTasks(completed: false);
    int total = taskBox.length;
    int completedCount = taskBox.values.where((t) => t.isDone).length;
    int pendingCount = total - completedCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        // Counters
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: $total"),
              Text("Pending: $pendingCount"),
              Text("Done: $completedCount"),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Today's date
        Center(
          child: Text(
            "Today: ${DateFormat.yMMMMd().format(DateTime.now())}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        // Filters row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text("Priority: "),
              const SizedBox(width: 8),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: _priorityFilter,
                    items: ['All', 'High', 'Medium', 'Low']
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) => setState(() {
                      _priorityFilter = v!;
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              const Text("Category: "),
              const SizedBox(width: 8),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: _categoryFilter,
                    items: <String>['All']
                        .followedBy(taskBox.values.map((t) => t.category).toSet())
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) => setState(() {
                      _categoryFilter = v!;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: pending.isEmpty
              ? const Center(child: Text("No tasks found."))
              : ListView.builder(
                  itemCount: pending.length,
                  itemBuilder: (context, i) {
                    final task = pending[i];
                    return Card(
                      child: Dismissible(
                        key: Key(task.key.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (dir) async {
                          return await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Delete Task"),
                              content: const Text("Are you sure?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (dir) => _deleteTask(task),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              task.isPinned
                                  ? Icons.push_pin
                                  : Icons.push_pin_outlined,
                            ),
                            onPressed: () {
                              task.isPinned = !task.isPinned;
                              task.save();
                              setState(() {});
                            },
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat.yMMMd().format(task.date)),
                              if (task.startHour != null &&
                                  task.endHour != null)
                                Text(
                                  "${task.startHour!.toString().padLeft(2, '0')}:${task.startMinute!.toString().padLeft(2, '0')} - ${task.endHour!.toString().padLeft(2, '0')}:${task.endMinute!.toString().padLeft(2, '0')}",
                                ),
                              Text(task.description),
                            ],
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: task.isDone,
                                onChanged: (val) {
                                  task.isDone = val!;
                                  task.save();
                                  setState(() {});
                                },
                              ),
                              Text(
                                task.priority,
                                style: TextStyle(
                                  color: task.priority == "High"
                                      ? Colors.red
                                      : (task.priority == "Medium"
                                          ? Colors.orange
                                          : Colors.green),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            _navigateToAddTask(taskToEdit: task);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildCompletedTab() {
    final done = _getFilteredTasks(completed: true);
    return done.isEmpty
        ? const Center(child: Text("No completed tasks."))
        : ListView.builder(
            itemCount: done.length,
            itemBuilder: (ctx, i) {
              final task = done[i];
              return Card(
                child: ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(task.date)),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _buildTasksTab(),
      _buildCompletedTab(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO"),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
          if (_selectedIndex == 1)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: _deleteAllCompleted,
              tooltip: "Delete All Completed",
            ),
        ],
      ),
      body: tabs[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => _navigateToAddTask(),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: "Completed"),
        ],
      ),
    );
  }
}
