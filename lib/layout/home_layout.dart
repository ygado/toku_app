import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/cubit/home_cubit.dart';
import 'package:todo_app/layout/cubit/home_states.dart';
import 'package:todo_app/modules/login/cubit/login_cubit.dart';

import '../shared/component/components.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var formScaffold = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    taskController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext context) {
        final email = LoginCubit.get(context).emailController ?? '';
        return HomeCubit()
          ..setUserEmail(email)
          ..createDataBase();
      },
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              key: formScaffold,
              appBar: AppBar(
                title: Text(
                  cubit.appBarTitles[cubit.currentIndex],
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: LoginCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
                items: cubit.bottomNavBar,
              ),
              floatingActionButton: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (cubit.isBottomSheet) {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          cubit.insertDataToDataBase(
                            title: taskController.text,
                            time: timeController.text,
                            date: dateController.text,
                            userEmail: cubit.userEmail,
                          );
                          taskController.clear();
                          timeController.clear();
                          dateController.clear();
                          Navigator.pop(context);
                          cubit.changeBottomSheet(
                            isShow: false,
                            icon: Icons.add_task,
                          );
                        }
                      } else {
                        formScaffold.currentState!
                            .showBottomSheet((context) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultTextFormField(
                                          controller: taskController,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            debugPrint(value);
                                          },
                                          onFieldSubmitted: (value) {
                                            debugPrint(value);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'You Must Enter Task';
                                            }
                                            return null;
                                          },
                                          prefixIcon: Icons.task_alt_outlined,
                                          hintText: 'Enter Your Task',
                                          labelText: 'Enter Your Task',
                                        ),
                                        defaultSizeBox(height: 15.h),
                                        defaultTextFormField(
                                          controller: timeController,
                                          keyboardType: TextInputType.datetime,
                                          onChanged: (value) {
                                            debugPrint(value);
                                          },
                                          onFieldSubmitted: (value) {
                                            debugPrint(value);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'You Must Enter Time';
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) {
                                              if (value != null) timeController.text = value.format(context);
                                            });
                                          },
                                          readOnly: true,
                                          prefixIcon:
                                              Icons.watch_later_outlined,
                                          hintText: 'Enter Your Time',
                                          labelText: 'Enter Your Time',
                                        ),
                                        defaultSizeBox(height: 15.h),
                                        defaultTextFormField(
                                          controller: dateController,
                                          keyboardType: TextInputType.datetime,
                                          onChanged: (value) {
                                            debugPrint(value);
                                          },
                                          onFieldSubmitted: (value) {
                                            debugPrint(value);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'You Must Enter Date';
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                const Duration(days: 730),
                                              ),
                                            ).then((value) {
                                              if (value != null) {
                                                dateController.text = DateFormat.yMMMd().format(value);
                                              }
                                            });
                                          },
                                          readOnly: true,
                                          prefixIcon: Icons.calendar_month,
                                          hintText: 'Enter Your Date',
                                          labelText: 'Enter Your Date',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                            .closed
                            .then((value) {
                              cubit.changeBottomSheet(
                                isShow: false,
                                icon: Icons.add_task,
                              );
                            });
                        cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                      }
                    },
                    child: Icon(cubit.fabIcon, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              body: cubit.screens[cubit.currentIndex],
            ),
          );
        },
      ),
    );
  }
}
