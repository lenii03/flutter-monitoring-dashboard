import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'dart:math';

class MainContentWidget extends StatelessWidget {
  final int selectedIndex;
  const MainContentWidget({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Dashboard Overview';
    if (selectedIndex == 1) title = 'Task Scheduler Management';
    if (selectedIndex == 2) title = 'System Settings';

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.notifications_none_rounded, color: AppColors.textSecondary, size: 24),
              const SizedBox(width: 24),
              Container(width: 1, height: 24, color: AppColors.border),
              const SizedBox(width: 24),
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primaryBlue,
                child: Text('A', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              const Text('Admin User', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary, size: 20),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              if (selectedIndex == 1) 
                ElevatedButton.icon(
                  
                  onPressed: () => _showNewTaskModal(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('New Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              if (selectedIndex == 2)
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save_rounded, size: 18),
                  label: const Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.serverOnline,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: selectedIndex == 0 ? Colors.transparent : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: selectedIndex == 0 ? null : Border.all(color: AppColors.border),
              ),
              child: _buildContentBasedOnIndex(selectedIndex, title),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContentBasedOnIndex(int index, String title) {
    if (index == 0) return _buildDashboardOverview();
    if (index == 1) return _buildTaskTable();
    if (index == 2) return _buildSettingsPage();
    return Center(child: Text('Area ini nanti diisi konten untuk $title', style: TextStyle(color: Colors.grey[500])));
  }


  void _showNewTaskModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6), 
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.border.withOpacity(0.5)),
          ),
          title: const Text('Create New Task', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Task Details', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                const SizedBox(height: 16),
                _buildTextFieldTile('Schedule ID', 'Auto-generated (e.g., SCH_100X)'),
                const SizedBox(height: 16),
                _buildDropdownTile('Target Service', 'Service_1'),
                const SizedBox(height: 16),
                _buildDropdownTile('Execution Time', 'Immediately'),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Task successfully created!'),
                    backgroundColor: AppColors.serverOnline,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: const Text('Save Task'),
            ),
          ],
        );
      },
    );
  }


  Widget _buildTaskTable() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(AppColors.background.withOpacity(0.5)),
            dataRowHeight: 70,
            dividerThickness: 1,
            columns: const [
              DataColumn(label: Text('Schedule ID', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Execute Time', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Executed By', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Status', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold))),
            ],
            rows: List.generate(10, (index) {
              String status = 'Success';
              if (index == 2 || index == 7) status = 'Failed';
              if (index == 4) status = 'Pending';
              
              return DataRow(
                // TAMBAHKAN 1 BARIS INI AGAR EFEK HOVER NYALA:
                onSelectChanged: (value) {}, 

                color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return AppColors.primaryBlue.withOpacity(0.15); 
                  }
                  return null; 
                }),
                cells: [
                  DataCell(Text('SCH_100${index + 1}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
                  DataCell(Text('24 Feb 2026\n08:0${index} AM', style: const TextStyle(color: AppColors.textSecondary))),
                  DataCell(Row(children: [const CircleAvatar(radius: 12, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 14, color: Colors.white)), const SizedBox(width: 8), Text(index % 2 == 0 ? 'admin' : 'system', style: const TextStyle(color: AppColors.textPrimary))])),
                  DataCell(_buildStatusBadge(status)),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: AppColors.textSecondary), 
                      onPressed: () {},
                      splashRadius: 20,
                    )
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardOverview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Servers', '24', Icons.dns_rounded, Colors.blueAccent, '+2 from last week')),
              const SizedBox(width: 24),
              Expanded(child: _buildStatCard('Active Tasks', '186', Icons.task_alt_rounded, AppColors.serverOnline, 'In progress')),
              const SizedBox(width: 24),
              Expanded(child: _buildStatCard('System Alerts', '3', Icons.warning_amber_rounded, AppColors.serverOffline, 'Requires attention')),
              const SizedBox(width: 24),
              Expanded(child: _buildStatCard('Avg. Uptime', '99.8%', Icons.timer_rounded, Colors.purpleAccent, 'Across all nodes')),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 350,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Network Traffic', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Live monitoring of inbound/outbound requests', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(20, (index) {
                          final height = 50.0 + Random().nextInt(150);
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500), width: 12, height: height,
                            decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(height > 150 ? 1.0 : 0.4), borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Container(
                  height: 350,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recent System Logs', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.circle, size: 10, color: index == 0 ? AppColors.serverOffline : AppColors.textSecondary),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(index == 0 ? 'Service_3 failed to respond' : 'Scheduled task completed', style: TextStyle(color: index == 0 ? AppColors.serverOffline : AppColors.textPrimary, fontSize: 14)),
                                        const SizedBox(height: 4),
                                        Text('${index + 2} mins ago', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color iconColor, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: iconColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: iconColor, size: 20))
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor; Color textColor; IconData icon;
    switch (status) {
      case 'Success': bgColor = AppColors.serverOnline.withOpacity(0.15); textColor = AppColors.serverOnline; icon = Icons.check_circle_rounded; break;
      case 'Failed': bgColor = AppColors.serverOffline.withOpacity(0.15); textColor = AppColors.serverOffline; icon = Icons.cancel_rounded; break;
      default: bgColor = Colors.orangeAccent.withOpacity(0.15); textColor = Colors.orangeAccent; icon = Icons.pending_rounded;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: textColor.withOpacity(0.3))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: textColor, size: 14), const SizedBox(width: 6), Text(status, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12))]),
    );
  }

  Widget _buildSettingsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 20), const SizedBox(width: 8), const Text('Preferences', style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w600))]),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: AppColors.background.withOpacity(0.5), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(children: [
              SwitchListTile(title: const Text('Email Notifications', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)), subtitle: const Text('Receive daily digest and critical alerts', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)), value: true, activeColor: AppColors.primaryBlue, onChanged: (v) {}),
              const Divider(color: AppColors.border, height: 1),
              SwitchListTile(title: const Text('Push Notifications', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)), subtitle: const Text('Real-time alerts for server downtime', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)), value: false, activeColor: AppColors.primaryBlue, onChanged: (v) {}),
              const Divider(color: AppColors.border, height: 1),
              SwitchListTile(title: const Text('Dark Mode', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)), subtitle: const Text('Use dark theme across the dashboard', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)), value: true, activeColor: AppColors.primaryBlue, onChanged: (v) {}),
            ]),
          ),
          const SizedBox(height: 32),
          Row(children: [const Icon(Icons.dns_rounded, color: AppColors.textSecondary, size: 20), const SizedBox(width: 8), const Text('Server Configuration', style: TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w600))]),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: AppColors.background.withOpacity(0.5), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(children: [
              _buildTextFieldTile('WebSocket URL', 'wss://api.netmonitor.com/stream'),
              const Divider(color: AppColors.border, height: 1),
              _buildTextFieldTile('API Key', 'sk_live_***********************'),
              const Divider(color: AppColors.border, height: 1),
              _buildDropdownTile('Auto-Refresh Interval', '5 Seconds'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldTile(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
          Expanded(
            flex: 2,
            child: TextField(
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(hintText: placeholder, hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5)), filled: true, fillColor: AppColors.background, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdownTile(String label, String currentValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentValue, dropdownColor: AppColors.surface, style: const TextStyle(color: AppColors.textPrimary), icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary), isExpanded: true,
                  items: ['Immediately', '5 Seconds', 'Service_1', 'Service_2'].map((String value) { return DropdownMenuItem<String>(value: value, child: Text(value)); }).toList(),
                  onChanged: (v) {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}