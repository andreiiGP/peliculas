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
  // ignore: library_private_types_in_public_api
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
      imageUrl: 'assets/jhonwek.jpg',
      videoUrl:
          'https://filemoon.sx/e/1806jx2apo73/John_Wick_4-_Baba_Yaga__2023__1080p_WEB-DL_Latino_playhublite.com_.mp4',
    ),
    Movie(
      imageUrl: 'assets/mario.jpg',
      videoUrl: 'https://uqload.io/embed-ert42oi31sfx.html',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
    ),
    Movie(
      imageUrl: 'assets/guardianesga.jpg',
      videoUrl:
          'https://filemoon.sx/e/f39e44ewzkew/Guardianes_de_la_galaxia_Vol._3__2023__1080p_WEB-DL_Latino.mp4',
    ),
    Movie(
      imageUrl: 'assets/fastandfurios.jpg',
      videoUrl: 'https://filemoon.sx/e/t5gmin6de138/_1080p_Fast.X2023_L_.mp4',
    ),
    Movie(
      imageUrl: 'assets/flash.jpg',
      videoUrl:
          'https://filemoon.sx/e/erz0xn1mv4im/The_Flash__2023__-_1080p_BRrip_x264__4.6_Mbps___spa__eng_.mp4',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
    ),
    Movie(
      imageUrl: 'assets/transformers.jpg',
      videoUrl:
          'https://filemoon.sx/e/a7tperzsgrvu/Transformers_Rise_of_the_Beasts__2023__-_1080p_BDrip_x264__11.1_Mbps___spa__eng___1_.mp4',
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
            SizedBox(
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

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieScreen(movie: movie),
        ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: 17.0, vertical: 5.0), // Agrega el margen vertical
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              movie.imageUrl,
              height: 120.9,
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

  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Abre una página web para reproducir el video en línea
            // ignore: deprecated_member_use
            launch(movie
                .videoUrl); // Asegúrate de importar el paquete 'url_launcher'
          },
          child: const Text('Reproducir video'),
        ),
      ),
    );
  }
}
