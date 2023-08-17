import 'dart:io';

import 'package:test/test.dart';
import 'package:unleash_client/src/version.dart';
import 'package:yaml/yaml.dart' as yaml;

void main() {
  group('sdkVersion', () {
    test('matches that of pubspec.yaml', () {
      final dynamic pubspec = yaml.loadYaml(
        File('pubspec.yaml').readAsStringSync(),
      );
      expect(version, pubspec['version']);
    });
  });
}
