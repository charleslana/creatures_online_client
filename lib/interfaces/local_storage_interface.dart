abstract class ILocalStorage {
  Future<T?> get<T>(String key);
  Future<dynamic> delete(String key);
  Future<dynamic> put(String key, dynamic value);
}
