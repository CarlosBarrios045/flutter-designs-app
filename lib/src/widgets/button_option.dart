import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color1;
  final Color color2;
  final Function onPress;

  ButtonOption(
      {this.icon = FontAwesomeIcons.addressCard,
      this.title = 'Text',
      this.color1 = Colors.blueAccent,
      this.color2 = Colors.lightBlue,
      @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        _ButtonOptionBackground(
          onPress: onPress,
          color1: color1,
          color2: color2,
          icon: icon,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 140, width: 40),
            FaIcon(this.icon, size: 40, color: Colors.white),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                this.title,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
            SizedBox(width: 40),
          ],
        )
      ],
    ));
  }
}

class _ButtonOptionBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;
  final Function onPress;

  _ButtonOptionBackground(
      {this.icon, this.color1, this.color2, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(4, 6),
                blurRadius: 10.0)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            this.color1,
            this.color2,
          ])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          type: MaterialType.transparency,
          elevation: 6.0,
          color: Colors.transparent,
          child: InkWell(
            onTap: onPress,
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  right: -20,
                  child: FaIcon(this.icon,
                      size: 150, color: Colors.white.withOpacity(0.2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
