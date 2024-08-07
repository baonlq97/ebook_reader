import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
          headerTitle: "Settings", iconRes: Assets.drawable.icSearch),
      body: Container(
        height: double.maxFinite,
      )
    );
  }
}