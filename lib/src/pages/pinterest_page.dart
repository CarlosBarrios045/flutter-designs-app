import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Widgets
import 'package:designs_app/src/widgets/pinterest_menu.dart';

// Theme
import 'package:designs_app/src/theme/theme.dart';

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        body: Stack(
          children: [
            PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final show = Provider.of<_MenuModel>(context).show;
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Positioned(
        bottom: 20,
        child: Container(
            width: width > 500 ? width - 300 : width,
            height: 100,
            child: Row(children: [
              Spacer(),
              PinterestMenu(
                  backgroundColor: currentTheme.scaffoldBackgroundColor,
                  iconSelectedColor: currentTheme.accentColor,
                  show: show,
                  items: [
                    PinterestButton(
                        onPressed: () => print('Press 1'),
                        icon: Icons.pie_chart),
                    PinterestButton(
                        onPressed: () => print('Press 2'), icon: Icons.search),
                    PinterestButton(
                        onPressed: () => print('Press 3'),
                        icon: Icons.notifications),
                    PinterestButton(
                        onPressed: () => print('Press 4'),
                        icon: Icons.supervised_user_circle),
                  ]
                  // backgroundColor: Colors.black,
                  // iconSelectedColor: Colors.blue,
                  // iconUnselectedColor: Colors.white,
                  ),
              Spacer()
            ])));
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List items = List.generate(200, (i) => i);
  ScrollController controller = new ScrollController();
  double lastScrollOffset = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset >= 0) {
        Provider.of<_MenuModel>(context, listen: false).show =
            controller.offset < lastScrollOffset;
      }

      lastScrollOffset = controller.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = MediaQuery.of(context).size.width > 500 ? 3 : 2;

    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return new Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: currentTheme.accentColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;

  bool get show => this._show;

  set show(bool value) {
    this._show = value;
    notifyListeners();
  }
}
