// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_main_app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorMainAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorMainAppDatabaseBuilder databaseBuilder(String name) =>
      _$FloorMainAppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorMainAppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorMainAppDatabaseBuilder(null);
}

class _$FloorMainAppDatabaseBuilder {
  _$FloorMainAppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorMainAppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorMainAppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorMainAppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorMainAppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorMainAppDatabase extends FloorMainAppDatabase {
  _$FloorMainAppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AttendanceDao? _attendanceDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Attendance` (`id` INTEGER, `desc` TEXT, `latitude` REAL NOT NULL, `longitude` REAL NOT NULL, `timestamp` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AttendanceDao get attendanceDao {
    return _attendanceDaoInstance ??= _$AttendanceDao(database, changeListener);
  }
}

class _$AttendanceDao extends AttendanceDao {
  _$AttendanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _attendanceTableInsertionAdapter = InsertionAdapter(
            database,
            'Attendance',
            (AttendanceTable item) => <String, Object?>{
                  'id': item.id,
                  'desc': item.desc,
                  'latitude': item.lat,
                  'longitude': item.lon,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AttendanceTable> _attendanceTableInsertionAdapter;

  @override
  Future<List<AttendanceTable>> getAllItems() async {
    return _queryAdapter.queryList('SELECT * from Attendance',
        mapper: (Map<String, Object?> row) => AttendanceTable(
            row['longitude'] as double,
            row['latitude'] as double,
            row['timestamp'] as int,
            id: row['id'] as int?,
            desc: row['desc'] as String?));
  }

  @override
  Future<List<AttendanceTable>> getItemsById(int id) async {
    return _queryAdapter.queryList('SELECT * from Attendance WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AttendanceTable(
            row['longitude'] as double,
            row['latitude'] as double,
            row['timestamp'] as int,
            id: row['id'] as int?,
            desc: row['desc'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> clearAll() async {
    await _queryAdapter.queryNoReturn('DELETE from Attendance');
  }

  @override
  Stream<List<AttendanceTable>> watchAllItems() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Attendance ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => AttendanceTable(
            row['longitude'] as double,
            row['latitude'] as double,
            row['timestamp'] as int,
            id: row['id'] as int?,
            desc: row['desc'] as String?),
        queryableName: 'Attendance',
        isView: false);
  }

  @override
  Future<void> insertAttendance(AttendanceTable attendanceTable) async {
    await _attendanceTableInsertionAdapter.insert(
        attendanceTable, OnConflictStrategy.abort);
  }
}
