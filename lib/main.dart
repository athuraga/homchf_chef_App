import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homchf_chef_side/routes/custome_router.dart';
import 'package:homchf_chef_side/routes/route_names.dart';
import 'package:homchf_chef_side/utilities/prefConstatnt.dart';
import 'package:homchf_chef_side/utilities/preference.dart';
import 'package:sizer/sizer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'localization/lang_localizations.dart';
import 'localization/localization_constant.dart';
import 'constantsonesignal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            this._locale = local;
          })
        });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(
        oneSignalAppId); //this ‘oneSignalAppId’ is imported from constantsonesignal.dart file
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Sizer(
        //return OrientationBuilder
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: ThemeData(primaryColor: const Color(0xFFE43E3F)),
            locale: _locale,
            supportedLocales: [
              Locale(ENGLISH, 'US'),
              Locale(SPANISH, 'ES'),
              Locale(ARABIC, 'AE'),
            ],
            localizationsDelegates: [
              LanguageLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var local in supportedLocales) {
                if (local.languageCode == deviceLocal!.languageCode &&
                    local.countryCode == deviceLocal.countryCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            initialRoute:
                SharedPreferenceHelper.getBoolean(Preferences.is_logged_in) ==
                        true
                    ? homeRoute
                    : loginRoute,
            onGenerateRoute: CustomRouter.allRoutes,
          );
        },
      );
    }
  }
}
