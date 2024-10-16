abstract class ServicoApi<T> {
  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<void> post(T item);
  Future<void> patch(int id, T item);
  Future<void> delete(int id);
}