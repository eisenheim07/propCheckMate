import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:propcheckmate/businessLogic/cubit/home_cubit.dart';
import 'package:propcheckmate/ui/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'businessLogic/chopper/ApiService.dart';
import 'businessLogic/repo/AppRepo.dart';
import 'common/colors.dart';
import 'common/preffs_manager.dart';
import 'common/theme.dart';

class RootApp extends StatefulWidget {
  final SharedPreferences preffs;

  const RootApp({super.key, required this.preffs});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final apiService = ApiService.create();

  @override
  void initState() {
    super.initState();
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      log('${record.level.name}: ${record.time}: ${record.message}');
    });
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final preffs = PreferenceManager(widget.preffs);
        final appRepo = AppRepo(apiService: apiService);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit(appRepo)),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              home: SplashScreen(preffs: preffs)),
        );
      },
    );
  }
}
