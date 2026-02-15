import 'package:flutter/material.dart';
import 'logo-app.dart';
import 'opacity-anim.dart';

class AppInit extends StatefulWidget {
  const AppInit({super.key, required this.title});

  final String title;

  @override
  State<AppInit> createState() => _AppInit();
}

class _AppInit extends State<AppInit> {
  final GlobalKey<OpacityAnimState> _opacityKey = GlobalKey<OpacityAnimState>();

  Future<void> _startFadeLoop() async {
    while (mounted) {
      // important to stop when widget is disposed
      _opacityKey.currentState?.playAnim();
      await Future.delayed(Duration(seconds: 3));
      _opacityKey.currentState?.playAnimReverse();
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startFadeLoop();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: OpacityAnim(
            key: _opacityKey,
            OpaA: 0.0,
            OpaB: 1.0,
            duration: const Duration(seconds: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoApp(),
                Text("Developped by NacerEOP", style: TextStyle(fontSize: 32)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
