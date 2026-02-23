import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/dashboard_nav_bloc.dart';
// ignore: unused_import
import '../bloc/dashboard_nav_event.dart';
import '../bloc/dashboard_nav_state.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                // PERBAIKAN: Menghapus [200] dan langsung menggunakan primaryBlue
                Icon(Icons.hub_rounded, color: AppColors.primaryBlue, size: 32),
                const SizedBox(width: 12),
                const Text(
                  'NetMonitor',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildMenuItem(context, title: 'Dashboard', icon: Icons.dashboard_rounded, index: 0),
          _buildMenuItem(context, title: 'Task Scheduler', icon: Icons.schedule_rounded, index: 1),
          _buildMenuItem(context, title: 'Settings', icon: Icons.settings_rounded, index: 2),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required String title, required IconData icon, required int index}) {
    return BlocBuilder<DashboardNavBloc, DashboardNavState>(
      builder: (context, state) {
        final isActive = state.selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: InkWell(
            onTap: () => context.read<DashboardNavBloc>().add(NavigateToMenu(index)),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryBlue.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive ? AppColors.primaryBlue.withOpacity(0.5) : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  // PERBAIKAN: Menghapus [200] di sini juga
                  Icon(icon, color: isActive ? AppColors.primaryBlue : Colors.grey[400], size: 22),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive ? AppColors.textPrimary : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}