import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:photos/core/network.dart';
import 'package:photos/l10n/l10n.dart';
import 'package:photos/services/app_lifecycle_service.dart';
import 'package:photos/services/sync_service.dart';
import 'package:photos/ui/home_widget.dart';

final themeData = ThemeData(
  fontFamily: 'Ubuntu',
  brightness: Brightness.dark,
  hintColor: Colors.grey,
  accentColor: Color.fromRGBO(45, 194, 98, 0.2),
  buttonColor: Color.fromRGBO(45, 194, 98, 1.0),
  buttonTheme: ButtonThemeData().copyWith(
    buttonColor: Color.fromRGBO(45, 194, 98, 1.0),
  ),
  toggleableActiveColor: Colors.green[400],
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  appBarTheme: AppBarTheme().copyWith(
    color: Color.fromRGBO(10, 20, 20, 1.0),
  ),
  cardColor: Color.fromRGBO(10, 15, 15, 1.0),
  dialogTheme: DialogTheme().copyWith(
    backgroundColor: Color.fromRGBO(10, 15, 15, 1.0),
  ),
  textSelectionTheme: TextSelectionThemeData().copyWith(
    cursorColor: Colors.white.withOpacity(0.5),
  ),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(45, 194, 98, 1.0),
      ),
    ),
  ),
);

class EnteApp extends StatefulWidget {
  static const _homeWidget = HomeWidget();

  EnteApp({Key key}) : super(key: key);

  @override
  _EnteAppState createState() => _EnteAppState();
}

class _EnteAppState extends State<EnteApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ente",
      theme: themeData,
      home: EnteApp._homeWidget,
      debugShowCheckedModeBanner: false,
      navigatorKey: Network.instance.getAlice().getNavigatorKey(),
      builder: EasyLoading.init(),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppLifecycleService.instance.onAppInForeground();
      SyncService.instance.sync();
    } else {
      AppLifecycleService.instance.onAppInBackground();
    }
  }
}
