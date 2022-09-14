import 'package:hive/hive.dart';
import 'package:hive_cache_memory/constant/hive_constants.dart';

import 'model/user_model.dart';

abstract class ICacheManager<T> {
  final String key;
  Box<T>? _box;

  ICacheManager({required this.key});
  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox(key);
    }
  }

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);
  T? getItem(String key);
  List<T>? getValues();
  Future<void> putItem(String key, T item);
  Future<void> deleteItem(String key);
  void registerAdapters();
}

class UserCacheManager extends ICacheManager<User> {
  UserCacheManager({required super.key}) : super();

  @override
  Future<void> addItems(List<User> items) async {
    await _box?.addAll(items);
  }

  @override
  Future<void> putItems(List<User> items) async {
    await _box?.putAll(Map.fromEntries(items.map((e) => MapEntry(e.id, e))));
  }

  @override
  User? getItem(String key) {
    return _box?.get(key);
  }

  @override
  Future<void> putItem(String key, User item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> deleteItem(String key) async {
    await _box?.delete(key);
  }

  @override
  List<User>? getValues() {
    return _box?.values.toList();
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.userTypeId)) {
      Hive.registerAdapter(UserAdapter());
      Hive.registerAdapter(AddressAdapter());
      Hive.registerAdapter(GeoAdapter());
      Hive.registerAdapter(CompanyAdapter());
    }
  }
}
