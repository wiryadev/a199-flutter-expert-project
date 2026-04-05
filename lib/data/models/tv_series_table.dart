import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'tv_watchlist')
class TvSeriesTable extends Equatable {
  @PrimaryKey()
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final String firstAirDate;
  final String lastAirDate;
  final String originalName;
  final String originalLanguage;
  final String status;
  final String tagline;
  final String type;
  final String homepage;
  final bool inProduction;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final int? episodeRunTime;

  TvSeriesTable({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.originalName,
    required this.originalLanguage,
    required this.status,
    required this.tagline,
    required this.type,
    required this.homepage,
    required this.inProduction,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    this.episodeRunTime,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) {
    return TvSeriesTable(
      id: tvSeries.id,
      name: tvSeries.name,
      posterPath: tvSeries.posterPath,
      backdropPath: tvSeries.backdropPath,
      overview: tvSeries.overview,
      firstAirDate: tvSeries.firstAirDate,
      lastAirDate: tvSeries.lastAirDate,
      originalName: tvSeries.originalName,
      originalLanguage: tvSeries.originalLanguage,
      status: tvSeries.status,
      tagline: tvSeries.tagline,
      type: tvSeries.type,
      homepage: tvSeries.homepage,
      inProduction: tvSeries.inProduction,
      popularity: tvSeries.popularity,
      voteAverage: tvSeries.voteAverage,
      voteCount: tvSeries.voteCount,
      numberOfEpisodes: tvSeries.numberOfEpisodes,
      numberOfSeasons: tvSeries.numberOfSeasons,
      episodeRunTime: tvSeries.episodeRunTime,
    );
  }

  TvSeriesDetail toEntity({List<TvSeason> seasons = const []}) {
    return TvSeriesDetail(
      id: id,
      name: name,
      posterPath: posterPath,
      backdropPath: backdropPath,
      overview: overview,
      firstAirDate: firstAirDate,
      lastAirDate: lastAirDate,
      originalName: originalName,
      originalLanguage: originalLanguage,
      status: status,
      tagline: tagline,
      type: type,
      homepage: homepage,
      inProduction: inProduction,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      episodeRunTime: episodeRunTime,
      genres: [],
      languages: [],
      originCountry: [],
      seasons: seasons,
    );
  }

  TvSeries toListEntity() {
    return TvSeries.watchlist(
      id: id,
      name: name,
      posterPath: posterPath,
      overview: overview,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        backdropPath,
        overview,
        firstAirDate,
        lastAirDate,
        originalName,
        originalLanguage,
        status,
        tagline,
        type,
        homepage,
        inProduction,
        popularity,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfSeasons,
        episodeRunTime,
      ];
}
