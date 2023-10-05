import 'package:opentelemetry_dart/src/api/metrics/noop/noop_counter.dart';
import 'package:opentelemetry_dart/src/experimental_api.dart';

/// A no-op instance of a [Meter]
class NoopMeter implements Meter {
  @override
  Counter<T> createCounter<T extends num>(String name,
      {String? description, String? unit}) {
    return NoopCounter<T>();
  }
}
