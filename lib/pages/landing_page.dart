import 'package:creatures_online_client/components/green_button_component.dart';
import 'package:creatures_online_client/data/image_data.dart';
import 'package:creatures_online_client/providers/landing_provider.dart';
import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  bool isLoaded = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String version = "";

  @override
  void initState() {
    getVersion();
    showLoader();
    super.initState();
  }

  Future<void> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  Future<void> showLoader() async {
    Future.delayed(const Duration(seconds: 1), () {
      loading(context);
      ref.read(landingProvider.notifier).changeText("Conectando no servidor");
    });
    Future.delayed(const Duration(seconds: 3), () {
      ref.read(landingProvider.notifier).changeText("Tentando realizar login");
    });
    Future.delayed(const Duration(seconds: 5), () {
      ref.read(landingProvider.notifier).changeText("Obtendo dados da conta");
    });
    Future.delayed(const Duration(seconds: 6), () {
      pop(context);
      setState(() {
        isLoaded = true;
      });
    });
  }

  void showStarterUser() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton(
                onPressed: showRegisterUser,
                child: const Text('Não tenho conta'),
              ),
              ElevatedButton(
                onPressed: showLoginUser,
                child: const Text('Desejo fazer login'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showRegisterUser() {
    pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Cadastrar uma nova conta!'),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Informe o e-mail',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Informe a senha',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirme a senha',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: createAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Concluir'),
              ),
            ],
          ),
        );
      },
    );
  }

  void createAccount() {
    pop(context);
    print(emailController.text);
    pushReplacementNamed(context, homeRoute);
    // ref.read(landingProvider.notifier).changeText(context, "");
    // loading(context);
    // setState(() {
    //   isLoaded = false;
    // });
  }

  void showLoginUser() {
    pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Faça login na sua conta!'),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Informe o e-mail',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Informe a senha',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: login,
                child: const Text('Entrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void login() {
    pop(context);
    pushNamed(context, homeRoute);
    // ref.read(landingProvider.notifier).changeText(context, "");
    // loading(context);
    // setState(() {
    //   isLoaded = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final double creaturesHeight = MediaQuery.of(context).size.height * 0.5;
    final double logoHeight = MediaQuery.of(context).size.height * 0.3;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
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
                alignment: Alignment.topRight,
                child: Text(
                  version,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: creaturesHeight,
                      child: Image.asset(
                        creatures,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    if (isLoaded)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: GreenButtonComponent(
                              text: 'Começar!',
                              callback: showStarterUser,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
