import 'dart:async';

import 'package:floor/floor.dart';

abstract class LocalStorageRepository<E> {
  FutureOr<List<E>> getItems({String? keyOfId});

  FutureOr<E?> getItem({String? keyId});

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> add(E object);

  @delete
  Future<void> remove(E object);

  Future<void> deleteAll();
}
