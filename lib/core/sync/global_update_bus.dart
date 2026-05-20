import 'dart:async';

/// 🔥 Wrapper to carry data + source
class GlobalUpdate<T> {
  final T data;
  final String source;
  final List<String>? destination; //
  final String? type;
  final String? actionType; // e.g., 'create', 'update', 'delete'

  GlobalUpdate({
    required this.data,
    required this.source,
    this.destination,
    this.type,
    this.actionType,
  });
}

class GlobalUpdateBus<T> {
  final _controller = StreamController<GlobalUpdate<T>>.broadcast();

  Stream<GlobalUpdate<T>> get stream => _controller.stream;

  void emit({
    required T data,
    required String source,
    List<String>? destination,
    String? type,
    String? actionType,
  }) {
    _controller.add(
      GlobalUpdate<T>(
        data: data,
        source: source,
        destination: destination,
        type: type,
        actionType: actionType,
      ),
    );
  }

  void dispose() {
    _controller.close();
  }
}
