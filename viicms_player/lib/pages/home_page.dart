import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../api/api_client.dart';
import '../providers/locale_manager.dart';
import '../providers/theme_manager.dart';
import '../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    reqtest();
  }

  @override
  void initState() {
    super.initState();
    initialization();
    reqtest();
  }

  void initialization() async {
    // ignore_for_file: avoid_print
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready go!');
    FlutterNativeSplash.remove();
  }

  void reqtest() async {
    try {
      final response = await ApiClient().get('/api/v4/answer_later/count');
      print('[home_page] Data: $response.data');
    } catch (e) {
      print('[home_page] Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final themeManager = Provider.of<ThemeManager>(context);
    final localeManager = Provider.of<LocaleManager>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(l10n.title),
        actions: [
          IconButton(
            color: Colors.blueAccent,
            icon: const Icon(Icons.language),
            iconSize: 24.0,
            tooltip: 'LLL',
            onPressed: localeManager.toggleLanguage,
          ),
          SizedBox(width: 40),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          children: [
            ElevatedButton(
              onPressed: () => themeManager.toggleTheme(ThemeModeType.light),
              child: Text(l10n.lightTheme),
            ),
            ElevatedButton(
              onPressed: () => themeManager.toggleTheme(ThemeModeType.dark),
              child: Text(l10n.darkTheme),
            ),
            ElevatedButton(
              onPressed: () => themeManager.toggleTheme(ThemeModeType.system),
              child: Text(l10n.systemTheme),
            ),
            // Current theme
            Text(
              '${l10n.currentTheme}: ${_getThemeName(themeManager.themeMode, context)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Current language
            Text(
              '${l10n.language}: ${localeManager.locale.languageCode == 'en' ? l10n.english : l10n.chinese}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // Counter
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              width: 300.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: Text(
                  l10n.sampleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getThemeName(ThemeModeType mode, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case ThemeModeType.light:
        return l10n.lightTheme;
      case ThemeModeType.dark:
        return l10n.darkTheme;
      case ThemeModeType.system:
        return l10n.systemTheme;
    }
  }
}
