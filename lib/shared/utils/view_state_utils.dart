import 'package:plus_notes_app/shared/types/view_state_enum.dart';

bool isSuccess(ViewState state) {
  return state == ViewState.success;
}

bool isError(ViewState state) {
  return state == ViewState.error;
}

bool isLoading(ViewState state) {
  return state == ViewState.loading;
}
