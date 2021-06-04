import 'package:bloc_turorial/movie_app/blocs/home_bloc/home_bloc.dart';
import 'package:bloc_turorial/movie_app/data/core/api_client.dart';
import 'package:bloc_turorial/movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:bloc_turorial/movie_app/data/repositories/movie_repository_impl.dart';
import 'package:bloc_turorial/movie_app/presentation/pages/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'blocs/home_bloc/home_event.dart';

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => MovieCarouselBloc(
              movieRepository: MovieRepository(
                  MovieRemoteDataSourceImpl(ApiClient(Client()))))
            ..add(CarouselLoadEvent()))
    ], child: MovieHomePage());
  }
}
