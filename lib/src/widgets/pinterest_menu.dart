import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton({@required this.onPressed, @required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final bool show;

  final Color backgroundColor;
  final Color iconSelectedColor;
  final Color iconUnselectedColor;
  final List<PinterestButton> items;

  PinterestMenu(
      {this.show = true,
      this.backgroundColor = Colors.white,
      this.iconSelectedColor = Colors.blue,
      this.iconUnselectedColor = Colors.blueGrey,
      @required this.items});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _MenuModel(),
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: show ? 1.0 : 0.0,
            child: Builder(
              builder: (BuildContext context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Add Your Code here.
                  Provider.of<_MenuModel>(context, listen: false)
                      .backgroundColor = this.backgroundColor;
                  Provider.of<_MenuModel>(context, listen: false)
                      .iconSelectedColor = this.iconSelectedColor;
                  Provider.of<_MenuModel>(context, listen: false)
                      .iconUnselectedColor = this.iconUnselectedColor;
                });

                return _PinterestMenuBackground(child: _MenuItems(items));
              },
            )));
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  _PinterestMenuBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 10.0, spreadRadius: -5)
          ]),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> items;
  _MenuItems(this.items);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            items.length, (i) => _PinterestMenuButton(i, items[i])));
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<_MenuModel>(context);
    final isSelected = provider.itemSelected == index;

    return GestureDetector(
      child: Icon(item.icon,
          size: isSelected ? 30 : 25,
          color: isSelected
              ? provider.iconSelectedColor
              : provider.iconUnselectedColor),
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSelected = index;
        item.onPressed();
      },
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSelected;
  Color _backgroundColor = Colors.white;
  Color _iconSelectedColor = Colors.blue;
  Color _iconUnselectedColor = Colors.blueGrey;

  int get itemSelected => this._itemSelected;

  set itemSelected(int i) {
    this._itemSelected = i == itemSelected ? null : i;
    notifyListeners();
  }

  Color get backgroundColor => this._backgroundColor;

  set backgroundColor(Color color) {
    this._backgroundColor = color;
    notifyListeners();
  }

  Color get iconSelectedColor => this._iconSelectedColor;

  set iconSelectedColor(Color color) {
    this._iconSelectedColor = color;
    notifyListeners();
  }

  Color get iconUnselectedColor => this._iconUnselectedColor;

  set iconUnselectedColor(Color color) {
    this._iconUnselectedColor = color;
    notifyListeners();
  }
}
