import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class Movie {
  final String imageUrl;
  final String videoUrl; // Agrega la propiedad para el enlace de reproducción

  Movie({required this.imageUrl, required this.videoUrl});
}

class Peli extends StatefulWidget {
  const Peli({Key? key}) : super(key: key);

  @override
  _PeliState createState() => _PeliState();
}

class _PeliState extends State<Peli> {
  final List<Movie> sliderImages = [
    Movie(
      imageUrl: 'assets/spidermanSlider.jpeg',
      videoUrl: '',
    ),
    Movie(
      imageUrl: 'assets/soulSlider.jpg',
      videoUrl: '',
    ),
    Movie(
      imageUrl: 'assets/guardianesSlider.jpg',
      videoUrl: '',
    ),
    Movie(
      imageUrl: 'assets/deadpoolSlider.jpg',
      videoUrl: '',
    ),
    Movie(
      imageUrl: 'assets/timeistheenemi.jpeg',
      videoUrl: '',
    ),
    // Agrega más imágenes y enlaces de video para el slider según sea necesario
  ];

  final List<Movie> catalogMovies = [
    Movie(
      imageUrl: 'assets/spiderman.jpg',
      videoUrl:
          'https://filemoon.sx/e/jj6ekcwmub9m/Spider-Man_Into_the_Spider-Verse.2018.5.1_BRRIP.mp4',
    ),
    Movie(
      imageUrl: 'assets/soul.jpg',
      videoUrl: 'URL_DEL_VIDEO_DE_SOUL',
    ),
    Movie(
      imageUrl: 'assets/guardianes.jpg',
      videoUrl: 'URL_DEL_VIDEO_DE_GUARDIANES',
    ),
    // Agrega más películas con sus enlaces de video
  ];

  int _currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentIndex);

    // Configura un temporizador para desplazar automáticamente las imágenes del slider
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentIndex < sliderImages.length - 1) {
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
        title: const Text('Películas'),
      ),
      body: Container(
        color: Colors.black, // Establece el fondo negro
        child: Column(
          children: <Widget>[
            Container(
              height: 200, // Altura del slider
              child: PageView.builder(
                controller: _pageController,
                itemCount: sliderImages.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    sliderImages[index].imageUrl,
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
            const Divider(), // Agregar un separador visual
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: catalogMovies.length,
                itemBuilder: (context, index) {
                  return MovieTile(movie: catalogMovies[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final Movie movie;

  MovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieScreen(movie: movie),
        ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              movie.imageUrl,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class MovieScreen extends StatelessWidget {
  final Movie movie;

  MovieScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Abre una página web para reproducir el video en línea
            launch(movie
                .videoUrl); // Asegúrate de importar el paquete 'url_launcher'
          },
          child: Text('Reproducir video'),
        ),
      ),
    );
  }
}
