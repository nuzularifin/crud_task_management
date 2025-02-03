import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_task_management/core/themes/app_colors.dart';
import 'package:flutter_crud_task_management/core/themes/app_text_styles.dart';
import 'package:flutter_crud_task_management/domain/entities/task.dart';
import 'package:flutter_crud_task_management/presentation/bloc/task/task_bloc.dart';
import 'package:flutter_crud_task_management/presentation/screen/task_add_screen.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Homepage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<TaskBloc>(context),
                            child: TaskAddScreen(),
                          )));
            },
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {}
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskLoaded) {
            return showListData(state);
          }

          return const SizedBox(
            height: double.infinity,
            child: Center(
              child: Text('Empty Task'),
            ),
          );
        },
      ),
    );
  }

  Widget showListData(TaskLoaded state) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: state.tasks.isNotEmpty ? state.tasks.length : 0,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () {
              openDetailTask(context, state.tasks[index], index);
            },
            title: Text(
              state.tasks[index].title,
              style: AppTextStyles.labelblackbold16,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.tasks[index].description ?? '',
                    style: TextStyle(color: Colors.grey[700])),
                SizedBox(height: 4),
                Text(
                  DateFormat('d MMMM, yyyy')
                      .format(state.tasks[index].dueDate), // Formatting Date
                  style: TextStyle(
                      color: Colors.grey[600], fontStyle: FontStyle.italic),
                ),
              ],
            ),
            leading: Icon(
              Icons.task,
              color: AppColors.onprogress,
            ),
            trailing: IconButton(
                onPressed: () {
                  context.read<TaskBloc>().add(DeleteTaskEvent(index: index));
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: AppColors.error,
                )),
          ),
        );
      },
    );
  }

  void openDetailTask(context, Task task, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: TaskAddScreen(
                    selectedIndex: index,
                    isUpdated: true,
                    title: task.title,
                    description: task.description,
                    dueDate: DateTime.parse(task.dueDate.toString()),
                  ),
                )));
  }
}
