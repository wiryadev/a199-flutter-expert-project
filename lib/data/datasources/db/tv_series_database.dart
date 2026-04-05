import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:ditonton/data/datasources/dao/tv_series_watchlist_dao.dart';
import 'package:ditonton/data/models/tv_episode_table.dart';
import 'package:ditonton/data/models/tv_season_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';

part 'tv_series_database.g.dart';

@Database(
  version: 1,
  entities: [TvSeriesTable, TvSeasonTable, TvEpisodeTable],
)
abstract class TvSeriesDatabase extends FloorDatabase {
  TvSeriesWatchlistDao get tvSeriesWatchlistDao;
}