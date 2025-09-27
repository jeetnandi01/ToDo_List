import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task_model.dart';
import 'ui/home_page.dart';

class AppColors {
  static const Color primary = Color(0xFF2E7D32);        // Dark Green
  static const Color primaryLight = Color(0xFF66BB6A);
  static const Color accent = Color(0xFFFFC107);         // Amber
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF121212);
  static const Color onSurfaceLight = Color(0xFF212121);
  static const Color onSurfaceDark = Colors.white70;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surfaceLight,
          onSurface: AppColors.onSurfaceLight,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 2,
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: AppColors.primary,
        ),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryLight,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryLight,
          secondary: AppColors.accent,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.onSurfaceDark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryLight,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: AppColors.primaryLight,
        ),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      themeMode: _themeMode,
      home: HomePage(
        onThemeChanged: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
