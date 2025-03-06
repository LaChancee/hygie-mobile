import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hygie_mobile/presentation/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygie_mobile/presentation/authentification/auth_screen.dart';
import 'package:hygie_mobile/presentation/home_page.dart';
import 'package:provider/provider.dart';
import 'data/providers/dependance_test_provider.dart';

import 'commons/ui/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting(
      'fr', null); // Charge les données pour le français
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DependanceTestProvider()),
      ],
      child: MaterialApp(
        title: 'Hygie',
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
            return Splashscreen(); // Redirection vers l'écran de connexion sinon
          },
        ),
      ),
    );
  }
}
