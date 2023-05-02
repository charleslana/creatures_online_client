import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class WorldPage extends StatelessWidget {
  const WorldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('World'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => pushReplacementNamed(context, homeRoute),
          ),
        ),
        body: const Placeholder(),
      ),
    );
  }
}
