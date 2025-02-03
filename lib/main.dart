import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_task_management/core/themes/app_theme.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_crud_task_management/presentation/screen/login_screen.dart';
import 'package:flutter_crud_task_management/core/injection_container.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initializeDepedencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: BlocProvider(
          create: (_) => LoginBloc(di.sl()), child: const LoginScreen()),
    );
  }
}
