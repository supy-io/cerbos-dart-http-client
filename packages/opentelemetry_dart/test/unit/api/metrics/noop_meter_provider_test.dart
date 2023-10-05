@TestOn('vm')
import 'package:opentelemetry_dart/api.dart' as api;
import 'package:test/test.dart';
import 'package:opentelemetry_dart/src/api/metrics/noop/noop_meter_provider.dart';
import 'package:opentelemetry_dart/src/experimental_api.dart' as api;

void main() {
  group('MeterProvider:', () {
    setUp(() {});

    test('MeterProvider.get with name returns inert instance of Meter', () {
      final provider = NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider.get('testname');
      meter.createCounter('test').add(1);
    });
    test('MeterProvider.get with name+version returns inert instance of Meter',
        () {
      final provider = NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider.get('testname', version: 'version');
      meter.createCounter('test').add(1);
    });

    test(
        'MeterProvider.get with name+version+url returns inert instance of Meter',
        () {
      final provider = NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter =
          provider.get('testname', version: 'version', schemaUrl: 'url');
      meter.createCounter('test').add(1);
    });

    test(
        'MeterProvider.get with name+version+url+attributes returns inert '
        'instance of Meter', () {
      final provider = NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider
          .get('testname', version: 'version', schemaUrl: 'url', attributes: [
        api.Attribute.fromString('http.method', 'post'),
        api.Attribute.fromString('http.scheme', 'http')
      ]);
      meter.createCounter<int>('test').add(1);
      meter.createCounter<double>('test2').add(0.034);
    });
  });
}
