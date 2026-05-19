import 'package:flutter/material.dart';
import 'package:task_1/modules/home_views/home_views.dart';

import '../../shared/component/components.dart';

class RegisterViews extends StatefulWidget {
  const RegisterViews({super.key});

  @override
  State<RegisterViews> createState() => _RegisterViewsState();
}

class _RegisterViewsState extends State<RegisterViews> {
  bool isPassword = true;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController passwordAddress = TextEditingController();
  TextEditingController confirmPasswordAddress = TextEditingController();


  TextEditingController nameAddress = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        title: 'Register',
        iconsLeadin: Icons.arrow_back,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeViews();
              },
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  defaultTextField(
                    controller: nameAddress,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      print(value);
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your Name';
                      }
                    },
                    text: 'FirstName',
                    prefix: Icons.text_decrease,
                    isPassword: false,
                  ),
                  SizedBox(height: 15),
                  defaultTextField(
                    controller: emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      print(value);
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Your Email';
                      }
                    },
                    text: 'Enter Your Email',
                    prefix: Icons.email,
                    isPassword: false,
                  ),
                  SizedBox(height: 15),
                  defaultTextField(
                    controller: passwordAddress,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      print(value);
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid password';
                      }
                    },
                    text: 'Enter Your Password',
                    prefix: Icons.lock,
                    suffix: isPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    isPassword: isPassword,
                    suffixOnPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  defaultTextField(
                    controller: confirmPasswordAddress,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      print(value);
                    },
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password Not Match';
                      }
                      if(value!=passwordAddress.text){
                        return 'Password Not Match';
                      }
                    },
                    text: 'Confirm Password',
                    prefix: Icons.lock,
                    suffix: isPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    isPassword: isPassword,
                    suffixOnPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  defaultMaterialButton(
                    fonSize: 25,
                    text: 'Register',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(emailAddress.text);
                        print(passwordAddress.text);
                        print(nameAddress.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeViews();
                            },
                          ),
                        );
                      }
                    },
                    color: Colors.white,
                    containerColor: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
