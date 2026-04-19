import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvEpisodeResponse extends Equatable {
  TvEpisodeResponse({
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

  factory TvEpisodeResponse.fromJson(Map<String, dynamic> json) =>
      TvEpisodeResponse(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "air_date": airDate,
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvEpisode toEntity() {
    return TvEpisode(
      id: this.id,
      name: this.name,
      overview: this.overview,
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      episodeType: this.episodeType,
      productionCode: this.productionCode,
      runtime: this.runtime,
      seasonNumber: this.seasonNumber,
      showId: this.showId,
      stillPath: this.stillPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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
