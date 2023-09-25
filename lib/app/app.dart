
import 'package:flutter/material.dart';

import '../core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.intitlRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
