import 'package:films_app_flutter/providers/movies_provider.dart';
import 'package:films_app_flutter/search/search_delegate.dart';
import 'package:films_app_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProviders = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper(movies: moviesProviders.onDisplayMovies),
            // Slider de peliculas
            MovieSlider(
              movies: moviesProviders.onDisplayPopularMovies,
              onNextPage: () {
                moviesProviders.getPopularMovies();
              },
            ),
          ],
        ),
      ),
    );
  }
}
