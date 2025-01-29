import 'package:code_daily/pages/welcome/coffee_welcome.dart';
import 'package:code_daily/utils/app_logger.dart';
import 'package:code_daily/utils/context_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  AppLogger().debug('Feature - main');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, fontFamily: 'pretendard'),
    home: Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Feature test main'),
          ),
          body: Center(
            child: Column(
              children: [
                ListTile(
                  title: Text('coffee_welcome'),
                  onTap: () => context.navigateTo(CoffeeWelcome()),
                ),
              ],
            ),
          ));
    }),
  ));
}
