import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pages
import 'package:designs_app/src/pages/launcher_tablet_page.dart';
import 'package:designs_app/src/pages/launcher_page.dart';

// Providers
import 'package:designs_app/src/theme/theme.dart';
import 'package:designs_app/src/models/layout_model.dart';

// Preferences
import 'package:designs_app/src/config/preferences_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = PreferencesUser();
  await prefs.initPrefs();

  runApp(ChangeNotifierProvider(
    create: (_) => LayoutModel(),
    child: ChangeNotifierProvider(
        create: (_) => ThemeChanger(prefs.theme ?? 1), child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final width = MediaQuery.of(context).size.width;

          return width > 500 ? LauncherTabletPage() : LauncherPage();
        },
      ),
    );
  }
}
