import 'package:creatures_online_client/providers/landing_provider.dart';
import 'package:creatures_online_client/utils/data_image.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    showLoader();
    super.initState();
  }

  Future<void> showLoader() async {
    Future.delayed(const Duration(seconds: 1), () {
      ref
          .read(landingProvider.notifier)
          .changeText(context, "Conectando no servidor");
    });
    Future.delayed(const Duration(seconds: 3), () {
      ref
          .read(landingProvider.notifier)
          .changeText(context, "Tentando realizar login");
    });
    Future.delayed(const Duration(seconds: 5), () {
      ref
          .read(landingProvider.notifier)
          .changeText(context, "Obtendo dados da conta");
    });
    Future.delayed(const Duration(seconds: 6), () {
      pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double creaturesHeight = MediaQuery.of(context).size.height * 0.5;
    final double logoHeight = MediaQuery.of(context).size.height * 0.3;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: logoHeight,
                  child: Image.asset(
                    logo,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: creaturesHeight,
                  child: Image.asset(
                    creatures,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}