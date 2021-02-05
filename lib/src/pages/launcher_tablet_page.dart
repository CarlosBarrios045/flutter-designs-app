import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Routes
import 'package:designs_app/src/routes/routes.dart';

// Providers
import 'package:designs_app/src/theme/theme.dart';
import 'package:designs_app/src/models/layout_model.dart';

class LauncherTabletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    final layout = Provider.of<LayoutModel>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        title: Text('Diseños en Flutter - Tablet'),
      ),
      drawer: _MainMenu(),
      body: Row(
        children: [
          Container(
              width: 300.0, height: double.infinity, child: _ListOptions()),
          Container(
              width: 1.0,
              height: double.infinity,
              color: theme.darkTheme || theme.customTheme
                  ? Colors.grey
                  : Colors.black12),
          Expanded(child: layout.currentPage)
        ],
      ),
    );
  }
}

class _ListOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) =>
          Container(width: double.infinity, height: 1.0, color: Colors.black12),
      itemCount: pageRoutes.length,
      itemBuilder: (_, i) => ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 26.0),
        leading: FaIcon(pageRoutes[i].icon, color: Colors.grey),
        title: Text(pageRoutes[i].title),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () => Provider.of<LayoutModel>(context, listen: false)
            .currentPage = pageRoutes[i].page,
      ),
    );
  }
}

class _MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pTheme = Provider.of<ThemeChanger>(context);

    return Drawer(
        child: Container(
      child: Column(
        children: [
          SafeArea(
            child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  child: Text('JB',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )),
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Modo oscuro'),
            trailing: Switch(
                value: pTheme.darkTheme,
                activeColor: pTheme.currentTheme.accentColor,
                onChanged: (value) => pTheme.darkTheme = value),
          ),
          ListTile(
            leading: Icon(Icons.add_to_home_screen),
            title: Text('Modo alternativo'),
            trailing: Switch(
                value: pTheme.customTheme,
                activeColor: pTheme.currentTheme.accentColor,
                onChanged: (value) => pTheme.customTheme = value),
          ),
          Expanded(
            child: _ListOptions(),
          ),
        ],
      ),
    ));
  }
}
