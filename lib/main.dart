import 'package:flutter/material.dart';

import 'order/application/request_notification_permission.dart';
import 'order/presentation/order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    requestNotificationPermission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OrderPage(),
    );
  }
}
