import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) async {
    final result = await repository.getTvSeriesDetail(id);

    return result.fold(
      (failure) => Left(failure),
      (tvSeriesDetail) async {
        final seasonsWithEpisodes = await Future.wait(
          tvSeriesDetail.seasons.map((season) async {
            final seasonResult =
                await repository.getSeasonDetail(id, season.seasonNumber);
            return seasonResult.fold(
              (_) => season, // if failed, return season with empty episodes
              (seasonDetail) => seasonDetail,
            );
          }),
        );

        return Right(tvSeriesDetail.copyWith(seasons: seasonsWithEpisodes));
      },
    );
  }
}
