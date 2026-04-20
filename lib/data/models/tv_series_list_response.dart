import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:equatable/equatable.dart';

class TvSeriesListResponse extends Equatable {
  final List<TvSeriesResponse> results;

  TvSeriesListResponse({required this.results});

  factory TvSeriesListResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesListResponse(
        results: List<TvSeriesResponse>.from(
          (json["results"] as List)
              .map((x) => TvSeriesResponse.fromJson(x))
              .where((element) => element.posterPath != null),
        ),
      );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [results];
}
