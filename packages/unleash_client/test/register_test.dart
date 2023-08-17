import 'package:test/test.dart';
import 'package:unleash_client/src/register.dart';
import 'package:unleash_client/src/version.dart';

void main() {
  test('Register.toJson', () {
    final startTime = DateTime(2020, 6, 28);

    final register = Register(
      started: startTime,
      interval: 20,
      instanceId: 'instanceid',
      appName: 'appname',
      strategies: ['strategy1'],
    );

    expect(register.toJson(), <String, dynamic>{
      'started': startTime.toUtc().toIso8601String(),
      'sdkVersion': sdkVersion,
      'interval': 20,
      'instanceId': 'instanceid',
      'appName': 'appname',
      'strategies': ['strategy1']
    });
  });
}
