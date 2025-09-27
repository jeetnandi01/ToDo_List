import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class AddTaskPage extends StatefulWidget {
  final TaskModel? taskToEdit;
  final bool isDarkMode;

  const AddTaskPage({
    super.key,
    this.taskToEdit,
    this.isDarkMode = false,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descController;
  late DateTime _selectedDate;
  late String _priority;
  late String _repeat;
  late String _category;

  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  bool get isEditing => widget.taskToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final t = widget.taskToEdit!;
      _titleController = TextEditingController(text: t.title);
      _descController = TextEditingController(text: t.description);
      _selectedDate = t.date;
      _priority = t.priority;
      _repeat = t.repeat;
      _category = t.category;

      if (t.startHour != null && t.startMinute != null) {
        _startTime = TimeOfDay(hour: t.startHour!, minute: t.startMinute!);
      }
      if (t.endHour != null && t.endMinute != null) {
        _endTime = TimeOfDay(hour: t.endHour!, minute: t.endMinute!);
      }
    } else {
      _titleController = TextEditingController();
      _descController = TextEditingController();
      _selectedDate = DateTime.now();
      _priority = 'Medium';
      _repeat = 'None';
      _category = 'General';
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(context: context, initialTime: _startTime);
    if (picked != null) setState(() => _startTime = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(context: context, initialTime: _endTime);
    if (picked != null) setState(() => _endTime = picked);
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (isEditing) {
      final t = widget.taskToEdit!;
      t.title = _titleController.text;
      t.description = _descController.text;
      t.date = _selectedDate;
      t.priority = _priority;
      t.repeat = _repeat;
      t.category = _category;
      t.startHour = _startTime.hour;
      t.startMinute = _startTime.minute;
      t.endHour = _endTime.hour;
      t.endMinute = _endTime.minute;
      await t.save();
      Navigator.pop(context, 'updated');
    } else {
      final newTask = TaskModel(
        title: _titleController.text,
        description: _descController.text,
        date: _selectedDate,
        priority: _priority,
        repeat: _repeat,
        category: _category,
        startHour: _startTime.hour,
        startMinute: _startTime.minute,
        endHour: _endTime.hour,
        endMinute: _endTime.minute,
      );
      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Task" : "Add Task"),
        backgroundColor: widget.isDarkMode
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (val) =>
                    (val == null || val.isEmpty) ? "Enter title" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text("Due Date"),
                subtitle: Text(DateFormat.yMMMd().format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text("Start Time"),
                subtitle: Text(_startTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: _pickStartTime,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Text("End Time"),
                subtitle: Text(_endTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: _pickEndTime,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: const InputDecoration(labelText: "Priority"),
                items: ['Low', 'Medium', 'High']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => _priority = v!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _repeat,
                decoration: const InputDecoration(labelText: "Repeat"),
                items: ['None', 'Daily', 'Weekly', 'Monthly']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => _repeat = v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _category,
                decoration: const InputDecoration(labelText: "Category"),
                onChanged: (v) => _category = v,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isEditing ? "Update Task" : "Save Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
