import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/controllers/questions_controller.dart';
import 'package:mood_tracker/firebase_options.dart';
import 'package:mood_tracker/views/screens/home_screen.dart';
import 'package:mood_tracker/providers/selected_option_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuestionsController()),
        ChangeNotifierProvider(create: (context) => SelectedOptionProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
