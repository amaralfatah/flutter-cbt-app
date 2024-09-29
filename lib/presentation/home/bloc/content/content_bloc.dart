import 'package:bloc/bloc.dart';
import 'package:flutter_cbt_app/data/datasources/content_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/content_response_model.dart';

part 'content_event.dart';
part 'content_state.dart';
part 'content_bloc.freezed.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(const _Initial()) {
    on<_GetContentById>((event, emit) async{
      emit(const _Loading());
      final response = await ContentRemoteDatasource().getContentById(event.id);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
