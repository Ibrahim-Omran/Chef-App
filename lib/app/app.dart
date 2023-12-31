import 'package:chef_app/core/bloc/cubit/global_cubit.dart';
import 'package:chef_app/core/bloc/cubit/global_state.dart';
import 'package:chef_app/core/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context,state){
        return BlocBuilder<GlobalCubit,GlobalState>(
          builder: (context,build){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar',"EG"),
                Locale('en',"US"),
              ],
              locale: Locale(BlocProvider.of<GlobalCubit>(context).langCode),
              title: 'Chef App',
              theme: getAppTheme(),
              initialRoute: Routes.intitlRoute,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          }
        );
      },
    );
  }
}
