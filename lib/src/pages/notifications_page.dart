import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart' show BounceInDown, Bounce;

// Theme
import 'package:designs_app/src/theme/theme.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: currentTheme.accentColor,
          title: Text('Notifications Page'),
          centerTitle: true,
        ),
        body: Center(child: Text('Hello')),
        floatingActionButton: _FloatingButton(),
        bottomNavigationBar: _BottomNavigation(),
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return FloatingActionButton(
        backgroundColor: currentTheme.accentColor,
        child: FaIcon(FontAwesomeIcons.play),
        onPressed: () {
          final provider =
              Provider.of<_NotificationModel>(context, listen: false);

          // Sum number
          int number = provider.number;
          number++;

          // Set provider
          provider.number = number;

          // Repeat animation of new notification
          if (number >= 2) provider.bounceController.forward(from: 0.0);
        });
  }
}

class _BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<_NotificationModel>(context);
    final int number = provider.number;
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return BottomNavigationBar(
      currentIndex: provider.itemSelected,
      selectedItemColor: currentTheme.accentColor,
      onTap: (i) => provider.itemSelected = i,
      selectedFontSize: 12.0,
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bone,
            ),
            label: 'Bones'),
        BottomNavigationBarItem(
            icon: Stack(
              children: [
                FaIcon(
                  FontAwesomeIcons.bell,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    /* child: Icon(Icons.brightness_1,
                        size: 8.0, color: Colors.blue)) */
                    child: BounceInDown(
                      from: 10,
                      animate: number > 0,
                      child: Bounce(
                        controller: (controller) =>
                            provider.bounceController = controller,
                        from: 10,
                        child: Container(
                            child: Text(
                              '$number',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 6.0,
                              ),
                            ),
                            alignment: Alignment.center,
                            width: 12.0,
                            height: 12.0,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle)),
                      ),
                    ))
              ],
            ),
            label: 'Notifications'),
        BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.dog,
            ),
            label: 'My Dog'),
      ],
    );
  }
}

class _NotificationModel with ChangeNotifier {
  int _number = 0;
  int _itemSelected = 0;
  AnimationController _bounceController;

  int get number => this._number;

  set number(int value) {
    this._number = value;
    notifyListeners();
  }

  int get itemSelected => this._itemSelected;

  set itemSelected(int value) {
    this._itemSelected = value;
    notifyListeners();
  }

  AnimationController get bounceController => this._bounceController;

  set bounceController(AnimationController value) {
    this._bounceController = value;
    notifyListeners();
  }
}
