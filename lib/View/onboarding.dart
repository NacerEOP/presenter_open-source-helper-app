import 'package:flutter/material.dart';
import 'logo-app.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      // onboarding finished
      // repo.setOnboardingSeen(true);
      // context.go('/home');
    }
  }

  void _previous() {
    if (_index > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      // onboarding finished
      // repo.setOnboardingSeen(true);
      // context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(16), child: const LogoApp()),

            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                children: const [
                  _Page(
                    title: 'First Contact',
                    text:
                        'Welcome to Presenter, I see this is your first time opening the app, so lets just go over some quick configurations before you can start presenting like you never did before.',
                  ),
                  _Page(title: 'Order fast', text: 'Order fast'),
                  _Page(title: 'Enjoy your coffee', text: 'Enjoy your coffee'),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _previous,
                    child: Text('Previous'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(onPressed: _next, child: Text('Next')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final String text;
  final String title;
  const _Page({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
