import 'package:bloc_turorial/counter_app/counter_bloc.dart';
import 'package:bloc_turorial/movie_app/blocs/home_bloc/home_bloc.dart';
import 'package:bloc_turorial/movie_app/blocs/home_bloc/home_state.dart';
import 'package:bloc_turorial/movie_app/presentation/widgets/movie_cusrsol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = BlocProvider.of<CounterBloc>(context);
    print(l.state);

    return Scaffold(
      body: Center(
        child: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          builder: (_, state) {
            if (state is MovieCarouselLoaded)
              return CardCarousel(
                movies: state.movies,
                nextPage: () {},
              );
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
