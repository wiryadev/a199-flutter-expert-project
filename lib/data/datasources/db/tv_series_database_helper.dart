import 'package:ditonton/data/datasources/db/tv_series_database.dart';
import 'package:ditonton/data/models/tv_episode_table.dart';
import 'package:ditonton/data/models/tv_season_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

class TvSeriesDatabaseHelper {
  static TvSeriesDatabaseHelper? _instance;
  TvSeriesDatabaseHelper._();
  factory TvSeriesDatabaseHelper() =>
      _instance ?? (_instance = TvSeriesDatabaseHelper._());

  static TvSeriesDatabase? _database;

  Future<TvSeriesDatabase> get database async {
    if (_database == null) {
      _database =
          await $FloorTvSeriesDatabase.databaseBuilder('tv_series.db').build();
    }
    return _database!;
  }

  Future<void> insertTvSeriesWatchlist(TvSeriesDetail tvSeries) async {
    final db = await database;

    final tvSeriesTable = TvSeriesTable.fromEntity(tvSeries);
    final List<TvSeasonTable> seasonTables = [];
    final List<TvEpisodeTable> episodeTables = [];

    for (final season in tvSeries.seasons) {
      seasonTables.add(TvSeasonTable.fromEntity(season, tvSeries.id));
      for (final episode in season.episodes) {
        episodeTables.add(TvEpisodeTable.fromEntity(episode, season.id));
      }
    }

    await db.tvSeriesWatchlistDao.insertTvSeriesWatchlist(
      tvSeriesTable,
      seasonTables,
      episodeTables,
    );
  }

  Future<void> removeTvSeriesWatchlist(int tvSeriesId) async {
    final db = await database;
    await db.tvSeriesWatchlistDao.removeTvSeriesWatchlist(tvSeriesId);
  }

  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final db = await database;
    return await db.tvSeriesWatchlistDao.getTvSeriesById(id);
  }

  Future<List<TvSeasonTable>> getSeasonsByTvSeriesId(int tvSeriesId) async {
    final db = await database;
    return await db.tvSeriesWatchlistDao.getSeasonsByTvSeriesId(tvSeriesId);
  }

  Future<TvSeasonTable?> getSeasonDetail(
      int tvSeriesId, int seasonNumber) async {
    final db = await database;
    return await db.tvSeriesWatchlistDao
        .getSeasonDetail(tvSeriesId, seasonNumber);
  }

  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final db = await database;
    return await db.tvSeriesWatchlistDao.getWatchlistTvSeries();
  }
}
