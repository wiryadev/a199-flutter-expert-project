import 'package:ditonton/data/models/tv_episode_table.dart';
import 'package:ditonton/data/models/tv_season_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class TvSeriesWatchlistDao {
  @Query('SELECT * FROM tv_watchlist')
  Future<List<TvSeriesTable>> getWatchlistTvSeries();

  @Query('SELECT * FROM tv_watchlist WHERE id = :id')
  Future<TvSeriesTable?> getTvSeriesById(int id);

  @Query('SELECT * FROM tv_seasons WHERE tvSeriesId = :tvSeriesId')
  Future<List<TvSeasonTable>> getSeasonsByTvSeriesId(int tvSeriesId);

  @Query(
    'SELECT * FROM tv_seasons WHERE tvSeriesId = :tvSeriesId AND seasonNumber = :seasonNumber',
  )
  Future<TvSeasonTable?> getSeasonDetail(int tvSeriesId, int seasonNumber);

  @insert
  Future<void> insertTvSeries(TvSeriesTable tvSeries);

  @insert
  Future<void> insertEpisodes(List<TvEpisodeTable> episodes);

  @insert
  Future<void> insertSeasons(List<TvSeasonTable> seasons);

  @Query('DELETE FROM tv_watchlist WHERE id = :tvSeriesId')
  Future<void> deleteTvSeriesById(int tvSeriesId);

  @Query(
    'DELETE FROM tv_episodes WHERE seasonId IN (SELECT id FROM tv_seasons WHERE tvSeriesId = :tvSeriesId)',
  )
  Future<void> deleteEpisodesByTvSeriesSeasons(int tvSeriesId);

  @Query('DELETE FROM tv_seasons WHERE tvSeriesId = :tvSeriesId')
  Future<void> deleteSeasonsByTvSeriesId(int tvSeriesId);

  @transaction
  Future<void> insertTvSeriesWatchlist(
    TvSeriesTable tvSeries,
    List<TvSeasonTable> seasons,
    List<TvEpisodeTable> episodes,
  ) async {
    await insertTvSeries(tvSeries);
    await insertSeasons(seasons);
    await insertEpisodes(episodes);
  }

  @transaction
  Future<void> removeTvSeriesWatchlist(int tvSeriesId) async {
    await deleteEpisodesByTvSeriesSeasons(tvSeriesId);
    await deleteSeasonsByTvSeriesId(tvSeriesId);
    await deleteTvSeriesById(tvSeriesId);
  }
}
