import 'package:belajar_bloc/features/dashboard/persentation/widgets/main_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/dashboard_nav_bloc.dart';
import '../bloc/dashboard_nav_state.dart';
import '../widgets/sidebar_widget.dart';
// ignore: duplicate_import
import '../widgets/sidebar_widget.dart';
import '../widgets/right_panel_widget.dart';
// ignore: duplicate_import
import '../widgets/main_content_widget.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          const SizedBox(width: 260, child: SidebarWidget()),
          
          Expanded(
            child: BlocBuilder<DashboardNavBloc, DashboardNavState>(
              builder: (context, state) {
                return MainContentWidget(selectedIndex: state.selectedIndex);
              },
            ),
          ),
          
          const SizedBox(width: 320, child: RightPanelWidget()),
        ],
      ),
    );
  }
}
