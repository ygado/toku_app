import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/modules/login/cubit/login_states.dart';
import 'package:todo_app/modules/settings/changePassword.dart';
import 'package:todo_app/shared/component/components.dart';

import '../login/cubit/login_cubit.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await cubit.updateProfileImage();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: cubit.userImage != null
                        ? FileImage(File(cubit.userImage!))
                        : null,
                    child: cubit.userImage == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ),
                defaultSizeBox(height: 15.h),
                Text(
                  cubit.username ?? '',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: cubit.isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                defaultSizeBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: cubit.isDark ? Colors.grey[800] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'ThemeMode',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: cubit.isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Spacer(),
                          Switch(
                            value: cubit.isDark,
                            onChanged: (value) {
                              cubit.changeMode(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                defaultSizeBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: defaultMaterialButton(
                    text: 'ChangePassword',
                    onPressed: () {
                      defaultNavigator(context, ChangePassword());
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
