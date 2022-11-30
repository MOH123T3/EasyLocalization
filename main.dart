// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('mr')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(),
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: ScreenFirst());
  }
}

class ScreenFirst extends StatefulWidget {
  const ScreenFirst({Key? key}) : super(key: key);

  @override
  State<ScreenFirst> createState() => _ScreenFirstState();
}

class _ScreenFirstState extends State<ScreenFirst> {
  List<Language> languageList = [
    Language(
      langName: 'English',
      locale: const Locale('en'),
    ),
    Language(
      langName: 'हिंदी',
      locale: const Locale('hi'),
    ),
    Language(
      langName: 'मराठी',
      locale: const Locale('mr'),
    ),
  ];
  Language? selectedLang;

  @override
  Widget build(BuildContext context) {
    selectedLang = languageList.singleWhere((e) => e.locale == context.locale);

    return Scaffold(
      appBar: AppBar(
        title: Text('EasyLocalization'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: DropdownButton<Language>(
                underline: SizedBox(),
                focusColor: Colors.white,
                iconEnabledColor: Colors.purple,
                iconDisabledColor: Colors.black,
                //dropdownColor: Colors.green,
                iconSize: 18,
                elevation: 8,
                value: selectedLang,

                onChanged: (newValue) {
                  setState(() {
                    selectedLang = newValue!;
                  });
                  if (newValue!.langName == 'English') {
                    context.setLocale(const Locale('en'));
                  } else if (newValue.langName == 'हिंदी') {
                    context.setLocale(const Locale('hi'));
                  } else if (newValue.langName == 'मराठी') {
                    context.setLocale(const Locale('mr'));
                  }
                },
                items: languageList
                    .map<DropdownMenuItem<Language>>((Language value) {
                  return DropdownMenuItem<Language>(
                    value: value,
                    child: Text(
                      value.langName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.purple,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text("email_number".tr()),
            SizedBox(
              height: 50,
            ),
            Text("mobile_number".tr()),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class Language {
  Locale locale;
  String langName;
  Language({
    required this.locale,
    required this.langName,
  });
}
