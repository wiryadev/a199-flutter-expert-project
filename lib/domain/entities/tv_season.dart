import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  TvSeason({
    required this.airDate,
    required this.episodes,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final String? airDate;
  final List<TvEpisode> episodes;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  int get episodeCount => episodes.length;

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}