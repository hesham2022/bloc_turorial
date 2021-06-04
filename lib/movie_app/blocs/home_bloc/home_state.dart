import 'package:bloc_turorial/movie_app/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

abstract class MovieCarouselState extends Equatable {
  const MovieCarouselState();

  @override
  List<Object> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {}

class MovieCarouselError extends MovieCarouselState {}

class MovieCarouselLoaded extends MovieCarouselState {
  final List<MovieModel> movies;

  const MovieCarouselLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
