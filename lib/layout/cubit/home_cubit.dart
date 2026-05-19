import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/cubit/home_states.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks.dart';
import 'package:todo_app/modules/done_tasks/done_tasks.dart';
import 'package:todo_app/modules/new_tasks/new_tasks.dart';
import 'package:todo_app/modules/settings/setting_profile.dart';

import '../../modules/login/cubit/login_cubit.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> appBarTitles = [
    'NewTasks',
    'DoneTasks',
    'ArchiveTasks',
    'SettingProfile',
  ];
  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
    SettingProfile(),
  ];
  List<BottomNavigationBarItem> bottomNavBar = [
    BottomNavigationBarItem(icon: Icon(Icons.menu_outlined), label: 'NewTasks'),
    BottomNavigationBarItem(
      icon: Icon(Icons.done_outline_outlined),
      label: 'DoneTasks',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.archive_outlined),
      label: 'ArchiveTasks',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }

  bool isBottomSheet = false;
  IconData? fabIcon = Icons.add_task;
  void changeBottomSheet({required bool isShow, required IconData icon}) {
    isBottomSheet = isShow;
    fabIcon = icon;
    emit(HomeChangeFloatingIconState());
  }

  Database? database;
  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 2,
      onCreate: (database, version) {
        database
            .execute(
              'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT,user_email TEXT)',
            )
            .then((value) {
              debugPrint('DataBase Is Created');
            })
            .catchError((error) {
              debugPrint('Error When Creating DataBase ${error.toString()}');
            });
      },
      onUpgrade: (database, oldVersion, newVersion) {
        if (oldVersion < 2) {
          database.execute('ALTER TABLE todo ADD COLUMN user_email TEXT');
        }
      },
      onOpen: (database) {
        debugPrint('DataBase Is Opened');
        getDataFromDataBase(database);
      },
    ).then((value) {
      database = value;
      emit(HomeCreateDataBaseStates());
    });
  }

  void insertDataToDataBase({
    required String title,
    required String time,
    required String date,
    required String userEmail,
  }) {
    if (database == null) return;
    database!.transaction((txn) async {
      await txn
          .rawInsert(
            'INSERT INTO todo(title, time, date,status,user_email) VALUES(?, ?, ?,?,?)',
            [title, time, date, "new", userEmail],
          )
          .then((value) {
            debugPrint('$value Inserting Successfully');
            emit(HomeInsertDataToDataBaseStates());
            getDataFromDataBase(database);
          })
          .catchError((error) {
            debugPrint('Error When Inserting DataBase ${error.toString()}');
          });
    });
  }

  String userEmail = '';

  void setUserEmail(String email) {
    userEmail = email;
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database
        .rawQuery('SELECT * FROM todo WHERE user_email = ?', [userEmail])
        .then((value) {
          for (final action in value) {
            if (action['status'] == 'new')
              newTasks.add(action);
            else if (action['status'] == 'done')
              doneTasks.add(action);
            else
              archivedTasks.add(action);
          }

          debugPrint('$value GetData Successfully');
          emit(HomeGetDataFromDataBaseStates());
        })
        .catchError((error) {
          debugPrint('Error When Getting  DataBase ${error.toString()}');
        });
  }

  void updateDataFromDataBase({required String status, required int id}) {
    database!
        .rawUpdate('UPDATE todo SET status = ? WHERE id = ?', [status, id])
        .then((value) {
          debugPrint('$value Updating Successfully');
          emit(HomeUpdateDataFromDataBaseStates());
          getDataFromDataBase(database);
        })
        .catchError((error) {
          debugPrint('Error When Updating DataBase ${error.toString()}');
        });
  }

  void deleteDataFromDataBase({required int id}) {
    database!
        .rawDelete('DELETE FROM todo WHERE id = ?', [id])
        .then((value) {
          debugPrint('$value Delete Successfully');
          emit(HomeDeleteDataFromDataBaseStates());
          getDataFromDataBase(database);
        })
        .catchError((error) {
          debugPrint(
            'Error When Delete Data From DataBase ${error.toString()}',
          );
        });
  }

  void editTaskFromDataBase({
    required String title,
    required String time,
    required String date,
    required int id,
  }) {
    database!
        .rawUpdate(
          'UPDATE todo SET title = ? , time = ?,date = ? WHERE id = ?',
          [title, time, date, id],
        )
        .then((value) {
          debugPrint('$value Updating Successfully');
          getDataFromDataBase(database);
          emit(HomeEditDataFromDataBaseStates());
        })
        .catchError((error) {
          debugPrint('Error When Editing Task ${error.toString()}');
        });
  }
}
