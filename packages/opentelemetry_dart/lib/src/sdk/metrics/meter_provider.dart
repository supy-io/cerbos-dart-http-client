import 'package:logging/logging.dart';
import 'package:opentelemetry_dart/api.dart' as api;
import 'package:opentelemetry_dart/src/api/metrics/meter_key.dart';
import 'package:opentelemetry_dart/src/experimental_api.dart' as api;
import 'package:opentelemetry_dart/src/experimental_sdk.dart' as sdk;

import 'meter.dart';

const invalidMeterNameMessage = 'Invalid Meter Name';

class MeterProvider implements api.MeterProvider {
  final _meters = <MeterKey, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');

  @override
  sdk.Meter get(String? name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    if (name == null || name == '') {
      name = '';
      _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    }
    final key = MeterKey(name, version, schemaUrl, attributes);

    return _meters.putIfAbsent(key, () => sdk.Meter()) as Meter;
  }
}
