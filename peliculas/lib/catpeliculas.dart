import 'package:flutter/material.dart';

class Movie {
  final String imageUrl;

  Movie( this.imageUrl);
}

class peli extends StatelessWidget {
  final List<Movie> movies = [
    Movie('assets/spiderman.jpg'),
    Movie('https://image.tmdb.org/t/p/w342/lrZyrYCWiQO8ljwhH9sX5RlZN5l.jpg'),
    Movie('assets/spiderman.jpg'),
    // Agrega más películas aquí
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Películas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Catálogo de Películas'),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Puedes ajustar este valor según tu preferencia
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieTile(movie: movies[index]);
          },
        ),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 114, // Ajusta la altura de la tarjeta según tu preferencia
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    height: 115,
                    width: 400,
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
