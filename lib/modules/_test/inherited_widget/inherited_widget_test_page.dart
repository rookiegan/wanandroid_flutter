import 'package:wanandroid_flutter/dependency.dart';

class InheritedWidgetTestPage extends StatefulWidget {
  const InheritedWidgetTestPage({Key? key}) : super(key: key);

  static final routeName = "/InheritedWidgetTestPage";

  @override
  _InheritedWidgetTestPageState createState() => _InheritedWidgetTestPageState();
}

class _InheritedWidgetTestPageState extends State<InheritedWidgetTestPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget"),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),

            /// CountWidget 在InheritedWidget中
            InheritedState(
              count: _counter,
              child: Column(
                children: [
                  CountWidget(),

                  /// Count2Widget在InheritedWidget中，但它没有依赖InheritedWidget的数据，
                  /// 所以Count3Widget的didChangeDependencies不会被调用
                  Count3Widget(),
                ],
              ),
            ),

            /// Count2Widget 父祖先中InheritedWidget没有改变，
            /// 所以Count2Widget的didChangeDependencies不会被调用
            Count2Widget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Text("Debug"),
      ),
    );
  }
}

class InheritedState extends InheritedWidget {
  final int count;

  const InheritedState({
    Key? key,
    required this.count,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedState oldWidget) {
    "updateShouldNotify".d();
    return count != oldWidget.count;
  }

  static InheritedState? of(BuildContext buildContext) {
    return buildContext.dependOnInheritedWidgetOfExactType();
    // return buildContext.dependOnInheritedWidgetOfExactType<InheritedState>();
  }
}

class CountWidget extends StatefulWidget {
  CountWidget({Key? key}) : super(key: key);

  @override
  State<CountWidget> createState() {
    return _CountWidgetState();
  }
}

class _CountWidgetState extends State<CountWidget> {
  @override
  Widget build(BuildContext context) {
    "_CountWidgetState build".d();

    return SizedBox(
      child: Text("Count: ${InheritedState.of(context)?.count ?? "无"}"),
    );
  }

  /// 如果build方法中有依赖InheritedWidget的数据，且父或祖线widget中的InheritedWidget发送改变，且updateShouldNotify返回true是会被调用
  @override
  void didChangeDependencies() {
    "_CountWidgetState didChangeDependencies ".d();
    super.didChangeDependencies();
  }
}

class Count2Widget extends StatefulWidget {
  Count2Widget({Key? key}) : super(key: key);

  @override
  State<Count2Widget> createState() {
    return _Count2WidgetState();
  }
}

class _Count2WidgetState extends State<Count2Widget> {
  @override
  Widget build(BuildContext context) {
    "_Count2WidgetState build".d();

    return SizedBox(
      child: Text("Count: ${InheritedState.of(context)?.count ?? "无"}"),
    );
  }

  @override
  void didChangeDependencies() {
    "_Count2WidgetState didChangeDependencies ".d();
    super.didChangeDependencies();
  }
}

class Count3Widget extends StatefulWidget {
  Count3Widget({Key? key}) : super(key: key);

  @override
  State<Count3Widget> createState() {
    return _Count3WidgetState();
  }
}

class _Count3WidgetState extends State<Count3Widget> {
  @override
  Widget build(BuildContext context) {
    "_Count3WidgetState build".d();

    return SizedBox(
      child: Text("Count: 1"),
    );
  }

  /// 如果build方法中有依赖InheritedWidget的数据，且父或祖线widget中的InheritedWidget发送改变，且updateShouldNotify返回true是会被调用
  @override
  void didChangeDependencies() {
    "_Count3WidgetState didChangeDependencies ".d();
    super.didChangeDependencies();
  }
}
