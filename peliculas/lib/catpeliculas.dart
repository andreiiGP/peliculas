import 'package:flutter/material.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Movie {
  final String imageUrl;
  final String videoUrl;

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
    // Agrega más imágenes y enlaces de video para el slider según sea necesario
  ];

  final List<Movie> catalogMovies = [
    Movie(
      imageUrl: 'assets/spiderman.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=VEDhoip4KDU',
    ),
    Movie(
      imageUrl: 'assets/soul.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID_4',
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
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
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
            const Divider(),
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

class MovieScreen extends StatefulWidget {
  final Movie movie;

  MovieScreen({required this.movie});

  @override
  _MovieScreenState createState() => _MovieScreenState(movie: movie);
}

class _MovieScreenState extends State<MovieScreen> {
  final Movie movie;

  _MovieScreenState({required this.movie});

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(movie.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reproducir Video'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
