import 'package:wanandroid_flutter/dependency.dart';

class FloatWidget extends StatefulWidget {
  final Widget child;

  FloatWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<FloatWidget> createState() => _FloatWidgetState();
}

class _FloatWidgetState extends State<FloatWidget> {
  Offset offsetA = Offset(900.sp, 1600.sp);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        left: offsetA.dx,
        top: offsetA.dy,
        child: Draggable(
          child: widget.child,
          feedback: widget.child,
          childWhenDragging: Container(),
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            final screenSize = MediaQuery.of(context).size;
            final screenWidth = screenSize.width;
            final screenHeight = screenSize.height;
            offsetA = offset;
            setState(() {
              var x = offsetA.dx;
              var y = offsetA.dy;
              if (offsetA.dx < 0) {
                x = 20;
              }

              if (offsetA.dx > screenWidth - 100) {
                x = screenWidth - 100;
              }

              if (offsetA.dy < kBottomNavigationBarHeight + 50) {
                y = kBottomNavigationBarHeight + 50;
              }

              if (offsetA.dy > screenHeight - 100) {
                y = screenHeight - 100;
              }

              offsetA = Offset(x, y);
            });
          },
        ),
      ),
    ]);
  }
}
