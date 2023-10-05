// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry_dart/api.dart' as api;
import 'package:opentelemetry_dart/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('spanContext getters', () {
    final spanId = api.SpanId([4, 5, 6]);
    final traceId = api.TraceId([1, 2, 3]);
    const traceFlags = api.TraceFlags.none;
    final traceState = sdk.TraceState.empty();

    final spanContext =
        sdk.SpanContext(traceId, spanId, traceFlags, traceState);

    expect(spanContext.traceId, same(traceId));
    expect(spanContext.spanId, same(spanId));
    expect(spanContext.traceFlags, same(traceFlags));
    expect(spanContext.traceState, same(traceState));
  });
}
