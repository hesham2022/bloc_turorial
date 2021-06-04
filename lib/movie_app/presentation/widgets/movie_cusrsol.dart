import 'package:bloc_turorial/movie_app/data/core/api_constants.dart';
import 'package:bloc_turorial/movie_app/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class CardCarousel extends StatelessWidget {
  final List<MovieModel> movies;
  final _pageCtrl = PageController(initialPage: 1, viewportFraction: 0.3);
  final Function nextPage;

  CardCarousel({required this.movies, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageCtrl.addListener(() {
      if (_pageCtrl.position.pixels >=
          _pageCtrl.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageCtrl,
        itemCount: movies.length,
        itemBuilder: (context, i) => _card(context, movies[i]),
      ),
    );
  }

  Widget _card(BuildContext context, MovieModel movie) {
    final card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(
                      '${ApiConstants.BASE_IMAGE_URL}${movie.backdropPath}'),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ));

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }
}
