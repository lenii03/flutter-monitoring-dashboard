import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/server_status/server_status_bloc.dart';
import '../bloc/server_status/server_status_state.dart';

class RightPanelWidget extends StatelessWidget {
  const RightPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.panelBackground,
        border: Border(left: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.all(24.0),
      child: BlocBuilder<ServerStatusBloc, ServerStatusState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Engine Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: state.cpuUsage > 70 ? AppColors.serverOffline.withOpacity(0.5) : AppColors.primaryBlue.withOpacity(0.3), 
                      width: 8
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('CPU', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text(
                          '${state.cpuUsage}%', 
                          style: TextStyle(
                            color: state.cpuUsage > 70 ? AppColors.serverOffline : AppColors.primaryBlue, 
                            fontSize: 28, 
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              const Text(
                'Active Services',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final isOnline = state.serverStatuses[index]; 
                    return _buildServerStatus('Service_${index + 1}', isOnline);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildServerStatus(String name, bool isOnline) {
    final color = isOnline ? AppColors.serverOnline : AppColors.serverOffline;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(isOnline ? 0.6 : 0.8),
                  blurRadius: isOnline ? 8 : 12,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(name, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(isOnline ? 'Active' : 'Down', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}