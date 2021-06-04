import 'package:bloc_turorial/movie_app/data/repositories/movie_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final MovieRepository movieRepository;
  MovieCarouselBloc({
    required this.movieRepository,
  }) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if (event is CarouselLoadEvent) {
      final moviesEither = await movieRepository.getTrending();
      yield moviesEither.fold(
        (l) => MovieCarouselError(),
        (movies) {
          return MovieCarouselLoaded(
            movies: movies,
          );
        },
      );
    }
  }
}
