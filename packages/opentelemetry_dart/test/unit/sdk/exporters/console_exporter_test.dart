// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:async';

import 'package:opentelemetry_dart/api.dart' as api;
import 'package:opentelemetry_dart/sdk.dart' as sdk;
import 'package:opentelemetry_dart/src/sdk/trace/span.dart';
import 'package:test/test.dart';

List<String> printLogs = [];

dynamic overridePrint(Function() testFn) => () {
      final spec = ZoneSpecification(print: (_, __, ___, msg) {
        // Add to log instead of printing to stdout
        printLogs.add(msg);
      });
      return Zone.current.fork(specification: spec).run<void>(testFn);
    };

void main() {
  tearDown(() {
    printLogs = [];
  });

  test('prints', overridePrint(() {
    final span = Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary('library_name', 'library_version'))
      ..end();

    sdk.ConsoleExporter().export([span]);

    final expected = RegExp(
        r'{traceId: 010203, parentId: 040506, name: foo, id: 070809, timestamp: \d+, duration: \d+, flags: 00, state: , status: StatusCode.unset}');
    expect(printLogs.length, 1);
    expect(printLogs[0], matches(expected));
  }));

  test('does not print after shutdown', overridePrint(() {
    final span = Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary('library_name', 'library_version'));

    sdk.ConsoleExporter()
      ..shutdown()
      ..export([span]);

    expect(printLogs.length, 0);
  }));
}
