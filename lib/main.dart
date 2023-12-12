import 'package:flutter/material.dart';

import 'features/contact_us/presentation/screens/contact_us_page.dart';
import 'injection_container.dart' as inj;

void main() async {
  runApp(const MyApp());
  await inj.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arbitrage app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ContactUsPage(),
    );
  }
}
