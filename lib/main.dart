import 'package:belajar_flutter_1/Menu3Page.dart';
import 'package:flutter/material.dart';
import 'Menu1Page.dart';
import 'Menu2Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu1Page()),
                );
              },
              child: buildMenuItem('Menu 1'),
            ),
            SizedBox(height: 20),
            AnimatedCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu2Page()),
                );
              },
              child: buildMenuItem('Menu 2'),
            ),
            SizedBox(height: 20),
            AnimatedCard(
              onTap: () {
                // Navigate to Menu3Page when the card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu3Page()),
                );
              },
              child: buildMenuItem('Menu 3'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Ribbon(),
        ],
      ),
    );
  }
}

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final Function() onTap;

  const AnimatedCard({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse().then((_) {
            widget.onTap();
          });
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value * 0.5 * 2 * 3.1415926535897932,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Ribbon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
