import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/tv_series_database_helper.dart';
import 'package:ditonton/data/models/tv_season_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlist(TvSeriesDetail tvSeries);
  Future<String> removeWatchlist(int tvSeriesId);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeasonTable>> getSeasonsByTvSeriesId(int tvSeriesId);
  Future<TvSeasonTable?> getSeasonDetail(int tvSeriesId, int seasonNumber);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final TvSeriesDatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvSeriesDetail tvSeries) async {
    try {
      await databaseHelper.insertTvSeriesWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<String> removeWatchlist(int tvSeriesId) async {
    try {
      await databaseHelper.removeTvSeriesWatchlist(tvSeriesId);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    return await databaseHelper.getTvSeriesById(id);
  }

  @override
  Future<List<TvSeasonTable>> getSeasonsByTvSeriesId(int tvSeriesId) async {
    return await databaseHelper.getSeasonsByTvSeriesId(tvSeriesId);
  }

  @override
  Future<TvSeasonTable?> getSeasonDetail(
    int tvSeriesId,
    int seasonNumber,
  ) async {
    return await databaseHelper.getSeasonDetail(tvSeriesId, seasonNumber);
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    return await databaseHelper.getWatchlistTvSeries();
  }
}
