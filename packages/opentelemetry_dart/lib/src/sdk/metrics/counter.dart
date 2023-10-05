import 'package:opentelemetry_dart/api.dart' as api;
import 'package:opentelemetry_dart/src/experimental_api.dart' as api;

class Counter<T extends num> implements api.Counter<T> {
  @override
  void add(T value, {List<api.Attribute>? attributes, api.Context? context}) {
    // TODO: implement add https://github.com/Workiva/opentelemetry-dart/issues/75
  }
}
