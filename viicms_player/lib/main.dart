import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:viicms_player/providers/locale_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'api/api_client.dart';
import 'utils/local_storage.dart';
import 'l10n/app_localizations.dart';
import 'providers/theme_manager.dart';
import 'theme/app_theme.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Local Storage
  await LocalStorage.init();
  // Dio Instance
  await ApiClient().init();
  // Build App
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleManager()),
        ChangeNotifierProvider(create: (context) => ThemeManager()),
      ],
      child: const MyApp(),
    ),
  );
}

// Router Config
final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(title: "Home Page"),
    ),
  ],
);

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          themeManager.themeMode == ThemeModeType.system
              ? ThemeMode.system
              : (themeManager.themeMode == ThemeModeType.dark
                  ? ThemeMode.dark
                  : ThemeMode.light),
      locale: localeManager.locale,
      supportedLocales: [Locale('en'), Locale('zh')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}
