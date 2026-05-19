import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/modules/login/cubit/login_cubit.dart';
import 'package:todo_app/modules/login/register/register_views.dart';
import 'package:todo_app/shared/component/components.dart';

import 'cubit/login_states.dart';

class LoginViews extends StatefulWidget {
  const LoginViews({super.key});

  @override
  State<LoginViews> createState() => _LoginViewsState();
}

class _LoginViewsState extends State<LoginViews> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                        'Login',
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          color: cubit.isDark ? Colors.white : Colors.black,
                        ),
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
                      defaultMaterialButton(
                        text: 'Login',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            bool isSuccess = await cubit.loginUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            if (isSuccess) {
                              FocusScope.of(context).unfocus();
                              emailController.clear();
                              passwordController.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomeLayout()),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Email Or Password Wrong'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      defaultSizeBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: cubit.isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              defaultNavigator(context, RegisterViews());
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: cubit.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
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
