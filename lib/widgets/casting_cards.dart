import 'package:films_app_flutter/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 180,
              child: CupertinoActivityIndicator(),
            );
          }

          final List<Cast> cast = snapshot.data!;

          return SizedBox(
            width: double.infinity,
            height: 180,
            child: ListView.builder(
                itemCount: cast.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => _CastCard(
                      actor: cast[index],
                    )),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key, required this.actor});

  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/images/no-image.jpg'),
            image: NetworkImage(actor.fullProfilePath),
            height: 140,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          actor.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
