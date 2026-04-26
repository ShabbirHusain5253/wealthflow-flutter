import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/config/router/app_router.dart';
import 'package:wealthflow/config/theme/app_theme.dart';
import 'package:wealthflow/core/di/init_dependencies.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_event.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeDependencies();
  runApp(const WealthFlowApp());
}

class WealthFlowApp extends StatelessWidget {
  const WealthFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(const AuthCheckRequested()),
        ),
      ],
      child: MaterialApp.router(
        title: 'WealthFlow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: sl<AppRouter>().router,
      ),
    );
  }
}
