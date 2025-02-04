import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_task_management/core/injection_container.dart';
import 'package:flutter_crud_task_management/core/themes/app_colors.dart';
import 'package:flutter_crud_task_management/core/themes/app_text_styles.dart';
import 'package:flutter_crud_task_management/core/themes/app_theme.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_event.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_state.dart';
import 'package:flutter_crud_task_management/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_crud_task_management/presentation/screen/dashboard_screen.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    } else if (value.length < 8) {
      return 'Username must be at least 8 characters';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8 || value.length > 15) {
      return 'Password must be 8-15 characters long.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    } else if (value.length < 8 || value.length > 15) {
      return 'Confirm Password must be 8-15 characters long.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF246fed),
                Color(0xFF4679cf),
                AppColors.primaryContainer,
                AppColors.primaryContainer,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3, 0.6, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(72),
                child: Lottie.asset('assets/anim/phone-gallery.json',
                    width: 175, height: 175, fit: BoxFit.contain),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CRUD Management App',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    const Text(
                      'Lets Manage Task and Do fun for execute the Task',
                      style: AppTextStyles.labelSmall12,
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: 'username',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateUsername,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _isPasswordObscured,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                          icon: Icon(_isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _confirmationPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: _isConfirmPasswordObscured,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordObscured =
                                  !_isConfirmPasswordObscured;
                            });
                          },
                          icon: Icon(_isConfirmPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 24.0),
                    BlocConsumer<LoginBloc, LoginState>(builder: (_, state) {
                      if (state is LoginLoading) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppTheme.buttonPrimary,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle login logic
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginRequest(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ));
                            }
                          },
                          child: const Text('Login'),
                        ),
                      );
                    }, listener: (_, state) {
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.success,
                            content: Text('Login successfully'),
                          ),
                        );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => TaskBloc(sl()),
                            child: const DashboardScreen(),
                          ),
                        ));
                      }
                      if (state is LoginFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.error,
                            content: Text('Login failed: ${state.message}'),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
