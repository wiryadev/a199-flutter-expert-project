import 'package:equatable/equatable.dart';

class TvEpisode extends Equatable {
  TvEpisode({
    required this.id,
    required this.name,
    required this.overview,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final int id;
  final String name;
  final String overview;
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        airDate,
        episodeNumber,
        episodeType,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
      ];
}

class SeasonDetail extends Equatable {
  SeasonDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.airDate,
    required this.episodes,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final int id;
  final String name;
  final String overview;
  final String? airDate;
  final List<TvEpisode> episodes;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        airDate,
        episodes,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
