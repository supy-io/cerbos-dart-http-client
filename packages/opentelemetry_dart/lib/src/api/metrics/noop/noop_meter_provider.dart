import 'package:opentelemetry_dart/api.dart';
import 'package:opentelemetry_dart/src/api/metrics/noop/noop_meter.dart';
import 'package:opentelemetry_dart/src/experimental_api.dart';

/// A noop registry for creating named [Meter]s.
class NoopMeterProvider implements MeterProvider {
  static final _noopMeter = NoopMeter();

  @override
  Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      List<Attribute> attributes = const []}) {
    return _noopMeter;
  }
}
