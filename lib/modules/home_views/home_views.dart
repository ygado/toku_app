import 'package:flutter/material.dart';
import 'package:task_1/modules/login/login_views.dart';
import 'package:task_1/shared/component/components.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        iconsLeadin: Icons.menu,
        title: 'Login',
        iconsAcction1: Icons.search,
        iconsAcction2: Icons.notifications,
      ),
      body: LoginViews(),
    );
  }
}
