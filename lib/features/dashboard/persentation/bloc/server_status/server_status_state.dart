class ServerStatusState {
  final List<bool> serverStatuses;
  final int cpuUsage;

  ServerStatusState({required this.serverStatuses, required this.cpuUsage});

  factory ServerStatusState.initial() {
    return ServerStatusState(
      serverStatuses: List.generate(8, (index) => true), 
      cpuUsage: 10,
    );
  }
}