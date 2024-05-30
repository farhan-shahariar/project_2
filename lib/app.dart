import 'package:project_2/product_list_screen.dart';
import 'package:flutter/material.dart';
class CrudApp extends StatelessWidget{
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const ProductListScreen(),
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
      themeMode: ThemeMode.system,
    );
  }

  ThemeData _lightThemeData(){
    return ThemeData(
      brightness: Brightness.light,
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
            )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
        )
    );
  }

  ThemeData _darkThemeData(){
    return ThemeData(
      brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
            )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
        )
    );
  }

}