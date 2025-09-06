import 'package:flutter/material.dart';
import 'package:test_app/models/menu_option.dart';
import 'package:test_app/router/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRouter.menuOptions;

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true),
      body: ListView.separated(
        itemCount: menuOptions.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final option = menuOptions[index];
          return ListTile(
            leading: Icon(option.icon, color: Theme.of(context).primaryColor),
            title: Text(option.name),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.pushNamed(context, option.route);
            },
          );
        },
      ),
    );
  }
}
