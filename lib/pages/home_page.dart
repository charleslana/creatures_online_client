import 'package:creatures_online_client/components/hud_info_component.dart';
import 'package:creatures_online_client/components/hud_user_component.dart';
import 'package:creatures_online_client/components/map_view_component.dart';
import 'package:creatures_online_client/components/menu_bottom_component.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const MapViewComponent(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    HudUserComponent(),
                    SizedBox(height: 20),
                    HudInfoComponent(),
                  ],
                ),
              ),
            ),
            const MenuBottomComponent(),
          ],
        ),
      ),
    );
  }
}
