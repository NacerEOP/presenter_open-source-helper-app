import 'package:flutter/material.dart';

import './Model/Services/shared-preferences.dart';
import 'Model/Repositories/app-params.dart';
import './ViewModel/appearance.dart';
import './ViewModel/states.dart';
import 'View/onboarding.dart';
import 'View/home.dart';
import 'View/app-init.dart';
// import 'View/home.dart';
// import 'View/login.dart';
// import 'View/settings.dart';

final States states = States();
final prefs = PreferencesService();
final repo = AppParamsRepository(prefs);
final themeVM = ThemeViewModel(repo);

Future<void> boot() async {
  await repo.LoadAll();

  await Future.delayed(const Duration(seconds: 2));

  final onboardSeen = await repo.getOnboardingSeen();
  states.go(onboardSeen ? 'home' : 'onboarding');
}

void main() {
  boot();

  themeVM.load();
  themeVM.setMode(ThemeMode.system);

  runApp(MyApp(themeVM));
}

class MyApp extends StatelessWidget {
  final ThemeViewModel themeVM;
  const MyApp(this.themeVM, {super.key});

  @override
  Widget build(BuildContext context) {
    // Map your "page name string" -> widget builder
    final pages = <String, Widget Function()>{
      'init': () => const AppInit(title: 'Presenter'),
      'onboarding': () => const OnboardingScreen(),
      'home': () => const HomeScreen(),
      // 'login': () => const LoginPage(),
      // 'settings': () => const SettingsPage(),
    };

    return AnimatedBuilder(
      // Listen to BOTH theme changes and page changes
      animation: Listenable.merge([themeVM, states]),
      builder: (context, _) {
        final pageName = states.page; // <-- your exposed string (example)
        final pageBuilder = pages[pageName] ?? pages['init']!;

        return MaterialApp(
          title: 'Presenter',
          themeMode: themeVM.mode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 72, 255, 0),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 72, 255, 0),
              brightness: Brightness.dark,
            ),
          ),
          home: pageBuilder(),
        );
      },
    );
  }
}
