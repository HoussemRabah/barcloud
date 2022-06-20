import 'package:barcloud/UI/screens/pages/homeAdmin.dart';
import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/repository/database_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../modules/class.dart';
import '../../functions/navigation.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task>? tasks = [];
  Task? taskOpened;
  int? tasksWaiting;
  int? tasksFinished;

  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) async {
      if (event is TaskEventInit) {
        taskBloc.add(TaskEventFetch());
      }
      if (event is TaskEventRefresh) {
        emit(TaskStateLoading());
        emit(TaskStateLoaded());
      }
      if (event is TaskEventCreate) {
        emit(TaskStateLoading());
        bool result = await databaseRepository.addTask(
            event.agentId,
            event.adminId,
            event.zoneId,
            event.title,
            event.disc,
            event.type,
            event.deadline);
        if (result) {
          Navigator.of(event.context).pop();
        }

        emit(TaskStateLoaded());
      }
      if (event is TaskEventFetch) {
        emit(TaskStateLoading());
        if (authBloc.authRepository.user!.role.name == "agent")
          tasks = await databaseRepository
              .getTasks(authBloc.authRepository.user!.id);
        else
          tasks = await databaseRepository.getAllTasks();

        tasksWaiting = getNumberTasksWaiting();
        tasksFinished = getNumberTasksFinished();

        if (tasks == null)
          emit(TaskStateError());
        else if (tasks!.isNotEmpty)
          emit(TaskStateLoaded());
        else
          emit(TaskStateEmpty());
      }
    });
  }

  int? getNumberTasksWaiting() => (tasks == null)
      ? null
      : (tasks)!
          .where(
            (element) => (element.process == TaskProcess.begin ||
                element.process == TaskProcess.wait),
          )
          .length;

  int? getNumberTasksFinished() => (tasks == null)
      ? null
      : (tasks)!
          .where(
            (element) => (element.process == TaskProcess.end),
          )
          .length;
}
