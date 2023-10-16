import 'package:flutter/material.dart';
import 'dart:async';

class Movie {
  final String imageUrl;
  final String title;

  Movie({required this.imageUrl, required this.title});
}

  class peli extends StatefulWidget {
    const peli({super.key});


  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<peli> {
  final List<Movie> movies = [
    Movie(
      imageUrl: 'assets/spidermanSlider.jpeg',
      title: 'Spiderman',
    ),
    Movie(
      imageUrl: 'assets/soulSlider.jpg',
      title: 'Soul',
    ),
    Movie(
      imageUrl: 'assets/guardianesSlider.jpg',
      title: 'Guardianes',
    ),
    Movie(
      imageUrl: 'assets/deadpoolSlider.jpg',
      title: 'Deadpool',
    ),
    Movie(
      imageUrl: 'assets/timeistheenemi.jpeg',
      title: 'Time is the Enemy',
    ),
    // Agrega más películas aquí
    Movie(
      imageUrl: 'assets/nuevapelicula1.jpeg',
      title: 'Nueva Película 1',
    ),
    Movie(
      imageUrl: 'assets/nuevapelicula2.jpeg',
      title: 'Nueva Película 2',
    ),
    // Agrega más películas según sea necesario
  ];

  int _currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentIndex);

    // Configura un temporizador para desplazar automáticamente las imágenes
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < movies.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
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
        title: const Text('Catálogo de Películas'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300, // Altura del slider
            child: PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  movies[index].imageUrl,
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
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieTile(movie: movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < movies.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
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

class MovieTile extends StatelessWidget {
  final Movie movie;

  MovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200, // Ajusta la altura de la tarjeta según tu preferencia
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Agrega más contenido si es necesario
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
