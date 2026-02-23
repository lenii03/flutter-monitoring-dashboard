import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/dashboard/persentation/bloc/dashboard_nav_bloc.dart';
import 'features/dashboard/persentation/bloc/server_status/server_status_bloc.dart'; 
import 'features/dashboard/persentation/pages/main_layout_page.dart';

void main() {
  runApp(const MonitoringApp());
}

class MonitoringApp extends StatelessWidget {
  const MonitoringApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Server Monitoring',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Segoe UI', 
      ),

      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DashboardNavBloc()),
          BlocProvider(create: (context) => ServerStatusBloc()), // Tambahkan BLoC baru di sini
        ],
        child: const MainLayoutPage(),
      ),
    );
  }
}