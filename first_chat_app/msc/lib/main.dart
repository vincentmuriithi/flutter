import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:msc/auth/auth_gate.dart";
import "package:msc/auth/login_or_register.dart";
import "package:msc/firebase_options.dart";

import "package:msc/home.dart";
import "package:msc/pages/register.dart";
import "package:msc/themes/theme_provider.dart";
import "package:provider/provider.dart";

import "account.dart";
import "themes/light_mode.dart";
import "pages/login.dart";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(create: (context) => ThemeProvider(),
        child: const App(),
      )
  );
}


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/account" : (context) => const Account(),
      }
    );
  }
}
