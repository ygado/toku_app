import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/modules/login/cubit/login_cubit.dart';

import '../../layout/cubit/home_cubit.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  Function()? onTap,
  Function()? onPressed,
  ValueChanged? onFieldSubmitted,
  ValueChanged? onChanged,
  FormFieldValidator? validator,
  bool isPassword = false,
  bool readOnly = false,
  required String labelText,
  required String hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
}) => TextFormField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
  validator: validator,
  controller: controller,
  keyboardType: keyboardType,
  onTap: onTap,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  obscureText: isPassword,
  readOnly: readOnly,
  decoration: InputDecoration(
    labelText: labelText,
    hintText: hintText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
    border: OutlineInputBorder(),
  ),
);
SizedBox defaultSizeBox({double? width, double? height}) =>
    SizedBox(width: width, height: height);

Widget defaultMaterialButton({Function()? onPressed, required String text}) =>
    Container(
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Future defaultNavigator(BuildContext context, Widget widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) {
      return widget;
    },
  ),
);

Widget defaultArticleModel(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: InkWell(
    onTap: () {
      TextEditingController titleController = TextEditingController(
        text: model['title'],
      );
      TextEditingController timeController = TextEditingController(
        text: model['time'],
      );
      TextEditingController dateController = TextEditingController(
        text: model['date'],
      );
      var cubit = HomeCubit.get(context);
      showModalBottomSheet(
        context: context,
        isScrollControlled:true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20.h,
              top: 20.h,
              right: 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  defaultTextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    onFieldSubmitted: (value) {
                      debugPrint(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                      if (value == null || value.isEmpty) {
                        return 'You Must Enter Time';
                      }
                      return null;
                    },
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        timeController.text = value!.format(context);
                      });
                    },
                    readOnly: true,
                    prefixIcon: Icons.watch_later_outlined,
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
                      if (value == null || value.isEmpty) {
                        return 'You Must Enter Date';
                      }
                      return null;
                    },
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2026-12-01'),
                      ).then((value) {
                        dateController.text = DateFormat.yMMMd().format(value!);
                        debugPrint(DateFormat.yMMM().format(value));
                      });
                    },
                    readOnly: true,
                    prefixIcon: Icons.calendar_month,
                    hintText: 'Enter Your Date',
                    labelText: 'Enter Your Date',
                  ),
                  defaultSizeBox(height: 15.h),
                  defaultMaterialButton(
                    text: 'Update',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      cubit.editTaskFromDataBase(
                        id: model['id'],
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
    child: SizedBox(
      width: double.infinity,
      height: 120.h,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.blue[200],
              child: Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                model['time'],
                style: TextStyle(
                  fontSize: 20.sp,
                  color: LoginCubit.get(context).isDark
                      ?  Colors.white : Colors.black,
                ),
              ),
            ),
            defaultSizeBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    model['title'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: LoginCubit.get(context).isDark
                          ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    model['date'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: LoginCubit.get(context).isDark
                          ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.blue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onPressed: () {
                HomeCubit.get(
                  context,
                ).updateDataFromDataBase(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.done,
                size: 30.sp,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            defaultSizeBox(width: 8.w),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.blue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onPressed: () {
                HomeCubit.get(
                  context,
                ).updateDataFromDataBase(status: 'archived', id: model['id']);
              },
              icon: Icon(
                Icons.archive_outlined,
                size: 30.sp,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  onDismissed: (index) {
    HomeCubit.get(context).deleteDataFromDataBase(id: model['id']);
  },
);

Widget defaultItem(List tasks) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          defaultArticleModel(tasks[index], context),
      separatorBuilder: (context, index) =>
          Container(color: Colors.grey, width: double.infinity, height: 1.h),
      itemCount: tasks.length,
    );
  },
  fallback: (context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 30.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, Please Enter Tasks',
            style: TextStyle(fontSize: 18.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  },
);
