// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $TvSeriesDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $TvSeriesDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $TvSeriesDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<TvSeriesDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorTvSeriesDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $TvSeriesDatabaseBuilderContract databaseBuilder(String name) =>
      _$TvSeriesDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $TvSeriesDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$TvSeriesDatabaseBuilder(null);
}

class _$TvSeriesDatabaseBuilder implements $TvSeriesDatabaseBuilderContract {
  _$TvSeriesDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $TvSeriesDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $TvSeriesDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<TvSeriesDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TvSeriesDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TvSeriesDatabase extends TvSeriesDatabase {
  _$TvSeriesDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TvSeriesWatchlistDao? _tvSeriesWatchlistDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tv_watchlist` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `posterPath` TEXT, `backdropPath` TEXT, `overview` TEXT NOT NULL, `firstAirDate` TEXT NOT NULL, `lastAirDate` TEXT NOT NULL, `originalName` TEXT NOT NULL, `originalLanguage` TEXT NOT NULL, `status` TEXT NOT NULL, `tagline` TEXT NOT NULL, `type` TEXT NOT NULL, `homepage` TEXT NOT NULL, `inProduction` INTEGER NOT NULL, `popularity` REAL NOT NULL, `voteAverage` REAL NOT NULL, `voteCount` INTEGER NOT NULL, `numberOfEpisodes` INTEGER NOT NULL, `numberOfSeasons` INTEGER NOT NULL, `episodeRunTime` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tv_seasons` (`id` INTEGER NOT NULL, `tvSeriesId` INTEGER NOT NULL, `name` TEXT NOT NULL, `overview` TEXT NOT NULL, `airDate` TEXT, `posterPath` TEXT, `seasonNumber` INTEGER NOT NULL, `voteAverage` REAL NOT NULL, FOREIGN KEY (`tvSeriesId`) REFERENCES `tv_watchlist` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tv_episodes` (`id` INTEGER NOT NULL, `seasonId` INTEGER NOT NULL, `name` TEXT NOT NULL, `overview` TEXT NOT NULL, `airDate` TEXT, `episodeNumber` INTEGER NOT NULL, `episodeType` TEXT NOT NULL, `productionCode` TEXT NOT NULL, `runtime` INTEGER, `seasonNumber` INTEGER NOT NULL, `showId` INTEGER NOT NULL, `stillPath` TEXT, `voteAverage` REAL NOT NULL, `voteCount` INTEGER NOT NULL, FOREIGN KEY (`seasonId`) REFERENCES `tv_seasons` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TvSeriesWatchlistDao get tvSeriesWatchlistDao {
    return _tvSeriesWatchlistDaoInstance ??=
        _$TvSeriesWatchlistDao(database, changeListener);
  }
}

class _$TvSeriesWatchlistDao extends TvSeriesWatchlistDao {
  _$TvSeriesWatchlistDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tvSeriesTableInsertionAdapter = InsertionAdapter(
            database,
            'tv_watchlist',
            (TvSeriesTable item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'posterPath': item.posterPath,
                  'backdropPath': item.backdropPath,
                  'overview': item.overview,
                  'firstAirDate': item.firstAirDate,
                  'lastAirDate': item.lastAirDate,
                  'originalName': item.originalName,
                  'originalLanguage': item.originalLanguage,
                  'status': item.status,
                  'tagline': item.tagline,
                  'type': item.type,
                  'homepage': item.homepage,
                  'inProduction': item.inProduction ? 1 : 0,
                  'popularity': item.popularity,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'numberOfEpisodes': item.numberOfEpisodes,
                  'numberOfSeasons': item.numberOfSeasons,
                  'episodeRunTime': item.episodeRunTime
                }),
        _tvEpisodeTableInsertionAdapter = InsertionAdapter(
            database,
            'tv_episodes',
            (TvEpisodeTable item) => <String, Object?>{
                  'id': item.id,
                  'seasonId': item.seasonId,
                  'name': item.name,
                  'overview': item.overview,
                  'airDate': item.airDate,
                  'episodeNumber': item.episodeNumber,
                  'episodeType': item.episodeType,
                  'productionCode': item.productionCode,
                  'runtime': item.runtime,
                  'seasonNumber': item.seasonNumber,
                  'showId': item.showId,
                  'stillPath': item.stillPath,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount
                }),
        _tvSeasonTableInsertionAdapter = InsertionAdapter(
            database,
            'tv_seasons',
            (TvSeasonTable item) => <String, Object?>{
                  'id': item.id,
                  'tvSeriesId': item.tvSeriesId,
                  'name': item.name,
                  'overview': item.overview,
                  'airDate': item.airDate,
                  'posterPath': item.posterPath,
                  'seasonNumber': item.seasonNumber,
                  'voteAverage': item.voteAverage
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TvSeriesTable> _tvSeriesTableInsertionAdapter;

  final InsertionAdapter<TvEpisodeTable> _tvEpisodeTableInsertionAdapter;

  final InsertionAdapter<TvSeasonTable> _tvSeasonTableInsertionAdapter;

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    return _queryAdapter.queryList('SELECT * FROM tv_watchlist',
        mapper: (Map<String, Object?> row) => TvSeriesTable(
            id: row['id'] as int,
            name: row['name'] as String,
            posterPath: row['posterPath'] as String?,
            backdropPath: row['backdropPath'] as String?,
            overview: row['overview'] as String,
            firstAirDate: row['firstAirDate'] as String,
            lastAirDate: row['lastAirDate'] as String,
            originalName: row['originalName'] as String,
            originalLanguage: row['originalLanguage'] as String,
            status: row['status'] as String,
            tagline: row['tagline'] as String,
            type: row['type'] as String,
            homepage: row['homepage'] as String,
            inProduction: (row['inProduction'] as int) != 0,
            popularity: row['popularity'] as double,
            voteAverage: row['voteAverage'] as double,
            voteCount: row['voteCount'] as int,
            numberOfEpisodes: row['numberOfEpisodes'] as int,
            numberOfSeasons: row['numberOfSeasons'] as int,
            episodeRunTime: row['episodeRunTime'] as int?));
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    return _queryAdapter.query('SELECT * FROM tv_watchlist WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TvSeriesTable(
            id: row['id'] as int,
            name: row['name'] as String,
            posterPath: row['posterPath'] as String?,
            backdropPath: row['backdropPath'] as String?,
            overview: row['overview'] as String,
            firstAirDate: row['firstAirDate'] as String,
            lastAirDate: row['lastAirDate'] as String,
            originalName: row['originalName'] as String,
            originalLanguage: row['originalLanguage'] as String,
            status: row['status'] as String,
            tagline: row['tagline'] as String,
            type: row['type'] as String,
            homepage: row['homepage'] as String,
            inProduction: (row['inProduction'] as int) != 0,
            popularity: row['popularity'] as double,
            voteAverage: row['voteAverage'] as double,
            voteCount: row['voteCount'] as int,
            numberOfEpisodes: row['numberOfEpisodes'] as int,
            numberOfSeasons: row['numberOfSeasons'] as int,
            episodeRunTime: row['episodeRunTime'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<TvSeasonTable>> getSeasonsByTvSeriesId(int tvSeriesId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tv_seasons WHERE tvSeriesId = ?1',
        mapper: (Map<String, Object?> row) => TvSeasonTable(
            id: row['id'] as int,
            tvSeriesId: row['tvSeriesId'] as int,
            name: row['name'] as String,
            overview: row['overview'] as String,
            airDate: row['airDate'] as String?,
            posterPath: row['posterPath'] as String?,
            seasonNumber: row['seasonNumber'] as int,
            voteAverage: row['voteAverage'] as double),
        arguments: [tvSeriesId]);
  }

  @override
  Future<TvSeasonTable?> getSeasonDetail(
    int tvSeriesId,
    int seasonNumber,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM tv_seasons WHERE tvSeriesId = ?1 AND seasonNumber = ?2',
        mapper: (Map<String, Object?> row) => TvSeasonTable(
            id: row['id'] as int,
            tvSeriesId: row['tvSeriesId'] as int,
            name: row['name'] as String,
            overview: row['overview'] as String,
            airDate: row['airDate'] as String?,
            posterPath: row['posterPath'] as String?,
            seasonNumber: row['seasonNumber'] as int,
            voteAverage: row['voteAverage'] as double),
        arguments: [tvSeriesId, seasonNumber]);
  }

  @override
  Future<void> deleteTvSeriesById(int tvSeriesId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM tv_watchlist WHERE id = ?1',
        arguments: [tvSeriesId]);
  }

  @override
  Future<void> deleteEpisodesByTvSeriesSeasons(int tvSeriesId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM tv_episodes WHERE seasonId IN (SELECT id FROM tv_seasons WHERE tvSeriesId = ?1)',
        arguments: [tvSeriesId]);
  }

  @override
  Future<void> deleteSeasonsByTvSeriesId(int tvSeriesId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM tv_seasons WHERE tvSeriesId = ?1',
        arguments: [tvSeriesId]);
  }

  @override
  Future<void> insertTvSeries(TvSeriesTable tvSeries) async {
    await _tvSeriesTableInsertionAdapter.insert(
        tvSeries, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertEpisodes(List<TvEpisodeTable> episodes) async {
    await _tvEpisodeTableInsertionAdapter.insertList(
        episodes, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertSeasons(List<TvSeasonTable> seasons) async {
    await _tvSeasonTableInsertionAdapter.insertList(
        seasons, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertTvSeriesWatchlist(
    TvSeriesTable tvSeries,
    List<TvSeasonTable> seasons,
    List<TvEpisodeTable> episodes,
  ) async {
    if (database is sqflite.Transaction) {
      await super.insertTvSeriesWatchlist(tvSeries, seasons, episodes);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$TvSeriesDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.tvSeriesWatchlistDao
            .insertTvSeriesWatchlist(tvSeries, seasons, episodes);
      });
    }
  }

  @override
  Future<void> removeTvSeriesWatchlist(int tvSeriesId) async {
    if (database is sqflite.Transaction) {
      await super.removeTvSeriesWatchlist(tvSeriesId);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$TvSeriesDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.tvSeriesWatchlistDao
            .removeTvSeriesWatchlist(tvSeriesId);
      });
    }
  }
}
