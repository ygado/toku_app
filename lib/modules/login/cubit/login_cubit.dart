import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/login/cubit/login_states.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../shared/network/local/shared_prefrence.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  bool isDark = false;
  void loadTheme() {
    isDark = CacheHelper.getData(key: 'isDark') ?? false;
    emit(LoginThemeChangedState());
  }

  void changeMode(bool value) {
    isDark = value;

    CacheHelper.putData(key: 'isDark', value: isDark);

    emit(LoginChangeModeState());
  }

  bool isPassword = true;
  void changeIconEye() {
    isPassword = !isPassword;
    emit(LoginChangeIconEyeState());
  }

  bool isConfirmPassword = true;
  void changeIconEyeConfirm() {
    isConfirmPassword = !isConfirmPassword;
    emit(LoginChangeIconEyeConfirmState());
  }

  bool isOldPassword = true;
  void changeIconEyeOld() {
    isOldPassword = !isOldPassword;
    emit(LoginChangeIconEyeOldState());
  }

  bool isNewPassword = true;
  void changeIconEyeNew() {
    isNewPassword = !isNewPassword;
    emit(LoginChangeIconEyeNewState());
  }

  bool isNewConfirmPassword = true;
  void changeIconEyeNewConfirm() {
    isNewConfirmPassword = !isNewConfirmPassword;
    emit(LoginChangeIconEyeNewConfirmState());
  }

  File? profileImage;
  String? userImage;
  final ImagePicker picker = ImagePicker();
  Database? database;
  void createDataBase() {
    openDatabase(
      'user.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
              'CREATE TABLE users (id INTEGER PRIMARY KEY, email TEXT,password TEXT,image TEXT,name TEXT )',
            )
            .then((value) {
              debugPrint('DataBase Is Created Successfully');
            })
            .catchError((error) {
              debugPrint('Error When Created DataBase ${error.toString()}');
            });
      },

      onUpgrade: (database, oldVersion, newVersion) async {
        await database.execute('ALTER TABLE users ADD COLUMN image TEXT');
      },
      onOpen: (database) {
        debugPrint('DataBase Is Opened Successfully');
        this.database = database;
      },
    ).then((value) {
      database = value;
      emit(LoginCreateDataBaseState());
    });
  }

  void insertDataToDataBase({
    required String userName,
    required String email,
    required String password,
    String? profileImage,
  }) {
    if (database == null) return;
    database!
        .transaction((txn) async {
          await txn.rawInsert(
            'INSERT INTO users(email, password,image,name) VALUES(?, ?,?,?)',
            [email, password, null, userName],
          );
        })
        .then((value) {
          emit(LoginInsertDataToDataBaseState());
        })
        .catchError((error) {
          debugPrint('Error When Created DataBase ${error.toString()}');
        });
  }

  String? emailController;
  String? username;
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email=? AND password=?',
      [email, password],
    );
    if (result.isNotEmpty) {
      emailController = email;
      username = result.first['name'];
      await getProfileImage();
      return true;
    }
    return false;
  }

  Future<bool> checkEmail({required String email}) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email=? ',
      [email],
    );
    return result.isNotEmpty;
  }

  Future<bool> checkPassword({required String password}) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE password=? ',
      [password],
    );
    return result.isNotEmpty;
  }

  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    List<Map> result = await database!.rawQuery(
      'SELECT * FROM users WHERE email=? AND password=? ',
      [emailController, oldPassword],
    );
    if (result.isNotEmpty) {
      await database!.rawUpdate('UPDATE users SET password=? WHERE email=?', [
        newPassword,
        emailController,
      ]);
      return true;
    }
    return false;
  }

  Future<void> updateProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      await database!.rawUpdate('UPDATE users SET image=? WHERE email=?', [
        pickedFile.path,
        emailController,
      ]);
      userImage = pickedFile.path;
      emit(LoginPickImageState());
    }
  }

  Future<void> getProfileImage() async {
    List<Map> result = await database!.rawQuery(
      'SELECT image FROM users WHERE email=?',
      [emailController],
    );

    if (result.isNotEmpty) {
      userImage = result.first['image'];

      emit(LoginGetImageState());
    }
  }

  void logout() {
    emailController = null;
    username = null;
    userImage = null;
    profileImage = null;
    emit(LoginLogoutState());
  }
}
