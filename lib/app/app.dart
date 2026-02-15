import 'package:decocom_memo_flutter/app/router.dart';
import 'package:decocom_memo_flutter/app/theme.dart';
import 'package:flutter/material.dart';

class DecocomApp extends StatelessWidget {
  const DecocomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Decocom Toolkit',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
