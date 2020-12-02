import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/team_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffe9EBF1),
          accentColor: Color(0xff01d468),
          primaryColor: Color(0xff00a294),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              color: Colors.transparent,
              elevation: 0.0,
              textTheme: TextTheme(
                  title: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  )))),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskProvider.init()),
        ],
        child: TaskScreen(),
      ),
    );
  }
}
