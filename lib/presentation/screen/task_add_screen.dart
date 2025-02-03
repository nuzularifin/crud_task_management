import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_task_management/core/themes/app_colors.dart';
import 'package:flutter_crud_task_management/domain/entities/task.dart';
import 'package:flutter_crud_task_management/presentation/bloc/task/task_bloc.dart';
import 'package:intl/intl.dart';

class TaskAddScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final DateTime? dueDate;
  int selectedIndex;
  bool isUpdated;

  TaskAddScreen(
      {super.key,
      this.title,
      this.description,
      this.dueDate,
      this.selectedIndex = -1,
      this.isUpdated = false});

  @override
  State<TaskAddScreen> createState() => CreateTaskScreenState();
}

class CreateTaskScreenState extends State<TaskAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _titleController.text = widget.title ?? '';
    }
    if (widget.description != null) {
      _descriptionController.text = widget.description ?? '';
    }
    if (widget.dueDate != null) {
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(widget.dueDate ?? DateTime.now());
    }
  }

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (_, state) {
          if (state is TaskAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.success,
                content: Text('Add Task successfully'),
              ),
            );
            Navigator.of(context).pop();
          } else if (state is TaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text('Task failed : ${state.message}'),
              ),
            );
          } else if (state is TaskUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.success,
                content: Text('Updated Task successfully'),
              ),
            );
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  maxLength: 50,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  decoration: InputDecoration(
                      labelText: 'title',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  keyboardType: TextInputType.text,
                  validator: _validateTitle,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  keyboardType: TextInputType.text,
                  validator: _validateTitle,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _dateController,
                  readOnly: true, // Biar user tidak bisa ketik manual
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400]),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle login logic
                        if (!widget.isUpdated) {
                          BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                              task: Task(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  dueDate:
                                      DateTime.parse(_dateController.text))));
                        } else {
                          BlocProvider.of<TaskBloc>(context)
                              .add(UpdateTaskEvent(
                                  task: Task(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    dueDate:
                                        DateTime.parse(_dateController.text),
                                  ),
                                  index: widget.selectedIndex));
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
