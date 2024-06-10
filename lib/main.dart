import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pico_placa/pages/home/homePage.dart';
import 'package:pico_placa/utils/constants.dart';
import 'package:pico_placa/utils/routes.dart';
import 'package:pico_placa/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.mainRed, // Establece el color de la barra de estado
    ));
    return MaterialApp(
      title: 'Admin POS Serie-S',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', ''), // Spanish, no country code
        Locale('en', ''), // English, no country code
      ],
      initialRoute: HomePage.routeName,
      //initialRoute: HomePageSelf.routeName,
      //initialRoute: DownloadAndOpenFile.routeName,
      routes: getAppRoutes(),
      theme: getAppTheme(),
    );
  }
}
