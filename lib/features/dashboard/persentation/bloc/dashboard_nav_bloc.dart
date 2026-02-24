import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_nav_event.dart';
import 'dashboard_nav_state.dart';

class DashboardNavBloc extends Bloc<DashboardNavEvent, DashboardNavState> {
  DashboardNavBloc() : super(DashboardNavState(selectedIndex: 0)) {
    
    on<NavigateToMenu>((event, emit) {
      emit(DashboardNavState(selectedIndex: event.index));
    });
  }
}