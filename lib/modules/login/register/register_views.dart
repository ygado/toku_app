import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/modules/login/cubit/login_cubit.dart';
import 'package:todo_app/modules/login/login_views.dart';
import 'package:todo_app/shared/component/components.dart';

import '../cubit/login_states.dart';

class RegisterViews extends StatefulWidget {
  const RegisterViews({super.key});

  @override
  State<RegisterViews> createState() => _RegisterViewsState();
}

class _RegisterViewsState extends State<RegisterViews> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    textController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          color: cubit.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: textController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Enter Name';
                          }
                          final regExp = RegExp(r'^[a-zA-Z][a-zA-Z ]{1,}$');
                          if (!regExp.hasMatch(value)) {
                            return 'Please Enter a valid Name ';
                          }
                          return null;
                        },
                        labelText: 'Enter Your Name',
                        hintText: 'Enter Your Name',
                        prefixIcon: Icons.text_increase,
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Enter Email';
                          }
                          final regExp = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!regExp.hasMatch(value)) {
                            return 'Please Enter a valid Email ';
                          }
                          return null;
                        },
                        labelText: 'Enter Your Email',
                        hintText: 'Enter Your Email',
                        prefixIcon: Icons.email_outlined,
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        isPassword: cubit.isPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Enter Password';
                          }
                          if (value.length < 6) {
                            return 'Please Enter a valid Password';
                          }
                          return null;
                        },
                        labelText: 'Enter Your Password',
                        hintText: 'Enter Your Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: cubit.isPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onPressed: () {
                          cubit.changeIconEye();
                        },
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultTextFormField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          debugPrint(value);
                        },
                        onFieldSubmitted: (value) {
                          debugPrint(value);
                        },
                        isPassword: cubit.isConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You Must Confirm Password';
                          }
                          if (value.length < 6) {
                            return 'Please Enter a valid Password';
                          }
                          return null;
                        },
                        labelText: 'Confirm Your Password',
                        hintText: 'Confirm Your Password',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: cubit.isConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onPressed: () {
                          cubit.changeIconEyeConfirm();
                        },
                      ),
                      defaultSizeBox(height: 15.h),
                      defaultMaterialButton(
                        text: 'Register',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Password Does Not Match'),
                                ),
                              );
                            }
                            bool checkEmail = await cubit.checkEmail(
                              email: emailController.text,
                            );
                            if (checkEmail) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Email Already exits')),
                              );
                            } else {
                              cubit.insertDataToDataBase(
                                userName: textController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Register Successfully'),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginViews()),
                                (route) => false,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
