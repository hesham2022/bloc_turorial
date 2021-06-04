import 'package:equatable/equatable.dart';

abstract class MovieCarouselEvent extends Equatable {
  const MovieCarouselEvent();

  @override
  List<Object> get props => [];
}

class CarouselLoadEvent extends MovieCarouselEvent {
  const CarouselLoadEvent();

  @override
  List<Object> get props => [CarouselLoadEvent];
}
