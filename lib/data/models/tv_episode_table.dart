import 'package:ditonton/data/models/tv_season_table.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'tv_episodes',
  foreignKeys: [
    ForeignKey(
      childColumns: ['seasonId'],
      parentColumns: ['id'],
      entity: TvSeasonTable,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TvEpisodeTable extends Equatable {
  @PrimaryKey()
  final int id;
  final int seasonId;
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

  TvEpisodeTable({
    required this.id,
    required this.seasonId,
    required this.name,
    required this.overview,
    this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    this.runtime,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvEpisodeTable.fromEntity(TvEpisode episode, int seasonId) {
    return TvEpisodeTable(
      id: episode.id,
      seasonId: seasonId,
      name: episode.name,
      overview: episode.overview,
      airDate: episode.airDate,
      episodeNumber: episode.episodeNumber,
      episodeType: episode.episodeType,
      productionCode: episode.productionCode,
      runtime: episode.runtime,
      seasonNumber: episode.seasonNumber,
      showId: episode.showId,
      stillPath: episode.stillPath,
      voteAverage: episode.voteAverage,
      voteCount: episode.voteCount,
    );
  }

  TvEpisode toEntity() {
    return TvEpisode(
      id: id,
      name: name,
      overview: overview,
      airDate: airDate,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    seasonId,
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
