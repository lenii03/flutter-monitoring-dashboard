import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_nav_event.dart';
import 'dashboard_nav_state.dart';

class DashboardNavBloc extends Bloc<DashboardNavEvent, DashboardNavState> {
  // Panggil dengan nama parameternya: selectedIndex: 0
  DashboardNavBloc() : super(DashboardNavState(selectedIndex: 0)) {
    
    on<NavigateToMenu>((event, emit) {
      // Panggil dengan nama parameternya: selectedIndex: event.index
      emit(DashboardNavState(selectedIndex: event.index));
    });
  }
}