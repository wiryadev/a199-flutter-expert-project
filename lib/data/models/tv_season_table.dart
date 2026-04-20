import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'tv_seasons',
  foreignKeys: [
    ForeignKey(
      childColumns: ['tvSeriesId'],
      parentColumns: ['id'],
      entity: TvSeriesTable,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TvSeasonTable extends Equatable {
  @PrimaryKey()
  final int id;
  final int tvSeriesId;
  final String name;
  final String overview;
  final String? airDate;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  TvSeasonTable({
    required this.id,
    required this.tvSeriesId,
    required this.name,
    required this.overview,
    this.airDate,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvSeasonTable.fromEntity(TvSeason season, int tvSeriesId) {
    return TvSeasonTable(
      id: season.id,
      tvSeriesId: tvSeriesId,
      name: season.name,
      overview: season.overview,
      airDate: season.airDate,
      posterPath: season.posterPath,
      seasonNumber: season.seasonNumber,
      voteAverage: season.voteAverage,
    );
  }

  TvSeason toEntity({List<TvEpisode> episodes = const []}) {
    return TvSeason(
      id: id,
      name: name,
      overview: overview,
      airDate: airDate,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
      episodes: episodes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    tvSeriesId,
    name,
    overview,
    airDate,
    posterPath,
    seasonNumber,
    voteAverage,
  ];
}
