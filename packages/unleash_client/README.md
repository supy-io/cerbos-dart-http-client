<p align="center">
  <img src="https://raw.githubusercontent.com/ueman/unleash/master/img/unleash.png" max-height="80" alt="Unleash" />
</p>

This library is a fork of the [unleash](https://pub.dev/packages/unleash/) package available on pub.dev.

My fork of the "unleash" package aims to provide additional features and improvements to the original package. I've built upon the foundation provided by the "unleash" package to create a version that meets my specific needs while also contributing back to the open-source community.

## Key Features

- Compatible with latest version of Flutter 

# Unleash Client SDK for Dart and Flutter

This is an unofficial Unleash Client SDK for Dart. It is compatible with the [Unleash-hosted.com SaaS](https://www.unleash-hosted.com/) offering and [Unleash Open-Source](https://github.com/unleash/unleash).
It also works with [GitLab Feature Flags](https://docs.gitlab.com/ee/user/project/operations/feature_flags.html).

## Getting started
First, you will need to add `unleash` to your `pubspec.yaml`:

```yaml
dependencies:
  unleash_client: x.y.z 
  # use the latest version found on pub.dev
```

Then, run `flutter packages get` in your terminal.

### Create a new Unleash instance

It is easy to get a new instance of Unleash. In your app you typically *just want one instance of Unleash*, and inject that where you need it. 

To create a new instance of Unleash you need to pass in a config object:
```dart
import 'package:unleash/unleash.dart';

Future<void> main() async {
  final unleash = await Unleash.init(
    UnleashSettings(
      appName: '<appname>',
      instanceId: '<instanceid>',
      unleashApi: Uri.parse('<api_url>'),
    ),
  );
  print(unleash.isEnabled('Awesome Feature'));
}
```

### Awesome feature toggle API

It is really simple to use unleash.

```dart
if(unleash.isEnabled("AwesomeFeature")) {
  //do some magic
} else {
  //do old boring stuff
}
```

Calling `unleash.isEnabled("AwesomeFeature")` is the equivalent of calling `unleash.isEnabled("AwesomeFeature", defaultValue: false)`. 
Which means that it will return `false` if it cannot find the named toggle. 

If you want it to default to `true` instead, you can pass `true` as the second argument:

```dart
unleash.isEnabled("AwesomeFeature", defaultValue: true);
```

## Built-in activation strategies

- [default](https://docs.getunleash.io/user_guide/activation_strategy#standard)
- [UserIDs](https://docs.getunleash.io/user_guide/activation_strategy#userids)

## Current state of development
This client SDK supports version 4 of the API.
This SDK currently does not support metrics reporting.

## Author

- Jonas Uekötter [GitHub](https://github.com/ueman) [Twitter](https://twitter.com/ue_man)

## Sponsoring
I'm working on my packages on my free-time, but I don't have as much time as I would. If this package or any other package I created is helping you, please consider to [sponsor](https://github.com/ueman#sponsor-me) me. By doing so, I will prioritize your issues or your pull-requests before the others.
