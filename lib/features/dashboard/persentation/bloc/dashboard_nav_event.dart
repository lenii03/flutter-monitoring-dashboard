abstract class DashboardNavEvent {}

class NavigateToMenu extends DashboardNavEvent {
  final int index;
  
  NavigateToMenu(this.index);
}