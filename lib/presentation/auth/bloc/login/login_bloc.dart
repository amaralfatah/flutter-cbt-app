import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cbt_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_cbt_app/data/models/request/login_request_model.dart';
import 'package:flutter_cbt_app/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());

      final response = await AuthRemoteDatasource().login(event.data);

      response.fold(
        (l) => emit(_Error(l)), // On error, emit error state with message
        (r) => emit(_Success(
            r)), // On success, emit success state with AuthResponseModel
      );
    });
  }
}
