import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/database/cach/cash%20helper.dart';
import 'package:todo_app/features/task/presentation/cubit/task_state.dart';

import 'core/database/sqflit/sqflit_helper.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/screens/splash/splash screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/task/presentation/cubit/task_cubit.dart';
import 'features/task/presentation/screens/home screen/home screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // create sharedPreferences object
  await CachHelper.init();
  // create Database object
  LocalDataBase object = LocalDataBase();
  object.createDatabase();
  // get data from cachHelper
  var screen = CachHelper.getData(key: "Bording");
  var isDark = CachHelper.getData(key: "isDark");
  runApp(MyApp(screen, isDark));
}


class MyApp extends StatelessWidget {
 late var screen;
 late var isDark;

  MyApp(this.screen, this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(                           // widget to make responsive app
        designSize: const Size(360, 690),            // use length and width of your design
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return BlocProvider(
            create: (BuildContext context) =>
            AddTaskBloc()
              ..openDataBase()
              ..getTasks()
              ..enterHomeScreen(value: screen)
            ..changeThemeData(dark:isDark )
            ,
            child: BlocConsumer<AddTaskBloc,AddTaskState>(
              builder: (context,state)=>MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Todo App',
                theme: darkTheme(),
                darkTheme: lightTheme(),
                themeMode:AddTaskBloc.get(context).isDark == true ? ThemeMode.light : ThemeMode.dark,
                home: screen==true?const HomeScreen():AppSplashScreen(),
              ),
              listener: (context,state)=>{},
            )
          );
        }
    );
  }
}
