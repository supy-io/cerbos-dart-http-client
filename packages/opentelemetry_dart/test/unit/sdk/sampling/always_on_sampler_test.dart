// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry_dart/api.dart' as api;
import 'package:opentelemetry_dart/sdk.dart' as sdk;
import 'package:opentelemetry_dart/src/sdk/trace/span.dart';
import 'package:test/test.dart';

void main() {
  test('Context contains a Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final traceState = sdk.TraceState.fromString('test=onetwo');
    final testSpan = Span(
        'foo',
        sdk.SpanContext(
            traceId, api.SpanId([7, 8, 9]), api.TraceFlags.none, traceState),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary(
            'always_on_sampler_test', 'sampler_test_version'));
    final testContext = api.Context.current.withSpan(testSpan);

    final result = sdk.AlwaysOnSampler().shouldSample(
        testContext, traceId, testSpan.name, api.SpanKind.internal, [], []);

    expect(result.decision, equals(sdk.Decision.recordAndSample));
    expect(result.spanAttributes, equals([]));
    expect(result.traceState, same(traceState));
  });
  test('Context does not contain a Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final testSpan = Span(
        'foo',
        sdk.SpanContext(traceId, api.SpanId([7, 8, 9]), api.TraceFlags.none,
            sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary(
            'always_on_sampler_test', 'sampler_test_version'));

    final result = sdk.AlwaysOnSampler().shouldSample(api.Context.root, traceId,
        testSpan.name, api.SpanKind.internal, [], []);

    expect(result.decision, equals(sdk.Decision.recordAndSample));
    expect(result.spanAttributes, equals([]));
    expect(result.traceState.isEmpty, isTrue);
  });
}
