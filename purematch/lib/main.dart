import 'package:purematch/page/add_user_page.dart';
import 'package:purematch/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
}

class App extends StatelessWidget {
  final ThemeData theme = ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(44, 45, 48, 1),
      textTheme: GoogleFonts.didactGothicTextTheme(),
      cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        )
      ));

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const AddUserPage(),
        ),
      );
}
