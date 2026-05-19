import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/modules/home/home_views.dart';
import 'package:todo_app/modules/login/cubit/login_cubit.dart';
import 'package:todo_app/modules/login/cubit/login_states.dart';
import 'package:todo_app/modules/settings/changePassword.dart';
import 'package:todo_app/modules/settings/setting_profile.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/network/local/shared_prefrence.dart';

import 'modules/login/login_views.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit()..createDataBase()..loadTheme(),

      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleSpacing: 20.w,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  actionsIconTheme: IconThemeData(color: Colors.black),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  prefixIconColor: Colors.black,
                  suffixIconColor: Colors.black,
                  errorStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                  counterStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                colorScheme: ColorScheme.light(onSurface: Colors.black),
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.grey[100],
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.blueGrey[700],
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.black,
                  iconSize: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: Color(0xff1f1f1f),
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleSpacing: 20.w,
                  backgroundColor: Color(0xff1f1f1f),
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  actionsIconTheme: IconThemeData(color: Colors.white),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  prefixIconColor: Colors.white,
                  suffixIconColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
                  counterStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                colorScheme: ColorScheme.dark(onSurface: Colors.white),
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.black,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Color(0xff1f1f1f),
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.blueGrey,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.white,
                  iconSize: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              themeMode: cubit.isDark ? ThemeMode.dark:ThemeMode.light ,
              home: HomeViews(),
            ),
          );
        },
      ),
    );
  }
}
