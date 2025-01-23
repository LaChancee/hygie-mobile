import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/authentification/auth_screen.dart';
import 'package:hygie_mobile/presentation/home_page.dart';
import 'commons/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized(); // Pour assurer l'initialisation correcte
  await initializeDateFormatting('fr', null); // Charge les données pour le français
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.textColor),
          headlineMedium: TextStyle(color: AppColors.textColor),
        ),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return HomePage(); // Redirection vers HomePage si connecté
          }
          return AuthScreen(); // Redirection vers l'écran de connexion sinon
        },
      ),
    );
  }
}
