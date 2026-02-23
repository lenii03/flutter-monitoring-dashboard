abstract class ServerStatusEvent {}
class UpdateStatusEvent extends ServerStatusEvent {
  final List<bool> serverStatuses; 
  final int cpuUsage;        

  UpdateStatusEvent({required this.serverStatuses, required this.cpuUsage});
}