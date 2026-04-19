import 'package:ditonton/data/models/tv_episode_response.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetailResponse extends Equatable {
  TvSeasonDetailResponse({
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
  final List<TvEpisodeResponse> episodes;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailResponse(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        airDate: json["air_date"],
        episodes: List<TvEpisodeResponse>.from(
            json["episodes"].map((x) => TvEpisodeResponse.fromJson(x))),
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  TvSeason toEntity() {
    return TvSeason(
      id: this.id,
      name: this.name,
      overview: this.overview,
      airDate: this.airDate,
      episodes: this.episodes.map((e) => e.toEntity()).toList(),
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
      voteAverage: this.voteAverage,
    );
  }

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
