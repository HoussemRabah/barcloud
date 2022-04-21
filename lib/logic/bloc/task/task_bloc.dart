import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/repository/database_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../modules/class.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task>? tasks = [];
  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) async {
      if (event is TaskEventFetch) {
        emit(TaskStateLoading());
        tasks =
            await databaseRepository.getTasks(authBloc.authRepository.user!.id);
        if (tasks == null)
          emit(TaskStateError());
        else if (tasks!.isNotEmpty)
          emit(TaskStateLoaded());
        else
          emit(TaskStateEmpty());
      }
    });
  }
}
