import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'server_status_event.dart';
import 'server_status_state.dart';

class ServerStatusBloc extends Bloc<ServerStatusEvent, ServerStatusState> {
  Timer? _mockWebSocketTimer;

  ServerStatusBloc() : super(ServerStatusState.initial()) {
    
    on<UpdateStatusEvent>((event, emit) {
      emit(ServerStatusState(
        serverStatuses: event.serverStatuses,
        cpuUsage: event.cpuUsage,
      ));
    });

    _startSimulatedWebSocket();
  }


  void _startSimulatedWebSocket() {
    final random = Random();
    

    _mockWebSocketTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      
      List<bool> newStatuses = List.generate(8, (index) {
        return random.nextInt(100) < 90; 
      });

      int newCpu = 10 + random.nextInt(70);

      add(UpdateStatusEvent(serverStatuses: newStatuses, cpuUsage: newCpu));
    });
  }

  @override
  Future<void> close() {
    _mockWebSocketTimer?.cancel(); 
    return super.close();
  }
}