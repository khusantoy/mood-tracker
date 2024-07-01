import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:mood_tracker/firebase_options.dart';
import 'package:mood_tracker/utils/routes.dart';
import 'package:mood_tracker/views/screens/home_screen.dart';
import 'package:mood_tracker/views/screens/leaderboard_screen.dart';
import 'package:mood_tracker/views/screens/login_screen.dart';
import 'package:mood_tracker/views/screens/register_screen.dart';
import 'package:mood_tracker/views/screens/reset_password_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return QuestionsController();
      },
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              }

              return const LoginScreen();
            },
          ),
          routes: {
            AppRoutes.home: (context) => const HomeScreen(),
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.register: (context) => const RegisterScreen(),
            AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
            AppRoutes.leaders: (context) => const LeaderboardScreen(),
          },
        );
      },
    );
  }
}
