import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: peli(),
    );
  }
}

class peli extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<peli> {
  final List<String> imageList = [
    'assets/spidermanSlider.jpeg',
    'assets/soulSlider.jpg',
    'assets/guardianesSlider.jpg',
    'assets/deadpoolSlider.jpg',
    'assets/timeistheenemi.jpeg',
    // Agrega más rutas de imágenes según sea necesario
  ];

  int _currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentIndex);

    // Configura un temporizador para desplazar automáticamente las imágenes
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < imageList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300, // Altura del slider
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  imageList[index],
                  fit: BoxFit.cover,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < imageList.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
