import 'package:chatter/firebase_options.dart';
import 'package:chatter/screens/splash.dart';
import 'package:chatter/services/database_provider.dart';
import 'package:chatter/styles/app_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseProvider(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppStyles.columbiaBlue,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: Splash(),
        supportedLocales: [Locale('es')],
        localizationsDelegates: [
          FirebaseUILocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
