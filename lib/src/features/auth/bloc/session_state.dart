import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/company.dart';

class SessionState {
  final Company? selectedCompany;
  SessionState({this.selectedCompany});
}

class SelectCompanyEvent {
  final Company company;
  SelectCompanyEvent(this.company);
}

class SessionBloc extends Bloc<SelectCompanyEvent, SessionState> {
  SessionBloc() : super(SessionState()) {
    on<SelectCompanyEvent>((event, emit) {
      emit(SessionState(selectedCompany: event.company));
    });
  }
}
