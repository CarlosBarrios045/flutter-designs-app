import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widgets
import 'package:designs_app/src/widgets/radial_progress.dart';

// Theme
import 'package:designs_app/src/theme/theme.dart';

class CircularGraphs extends StatefulWidget {
  @override
  _CircularGraphsState createState() => _CircularGraphsState();
}

class _CircularGraphsState extends State<CircularGraphs> {
  double porcent = 0.0;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: currentTheme.accentColor,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            porcent += 10;
            if (porcent > 100) {
              porcent = 0;
            }
          });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CustomRadialProgress(porcent: porcent, color: Colors.blue),
              _CustomRadialProgress(
                  porcent: porcent * 1.6, color: Colors.redAccent)
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomRadialProgress extends StatelessWidget {
  final double porcent;
  final Color color;

  _CustomRadialProgress({@required this.porcent, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 180.0,
        height: 180.0,
        child: RadialProgress(
          porcent: porcent,
          colorPrimary: color,
          colorSecundary: Colors.grey,
          widthSecundary: 6.0,
        ));
  }
}
