// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'open_dual_view_platform_interface.dart';

/// An implementation of [OpenDualViewPlatform] that uses method channels.
class MethodChannelOpenDualView extends OpenDualViewPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('open_dual_view');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<OpenDualViewResult> openInDualView(
    String? packageName,
    String? uri,
  ) async {
    try {
      if (packageName == null && uri == null) {
        return OpenDualViewResult(
          result: false,
          message: 'Either package name or URI is required',
        );
      }

      await methodChannel.invokeMethod<String>(
        'openDualView',
        {'packageName': packageName, 'uri': uri},
      );
      return OpenDualViewResult(result: true);
    } on PlatformException catch (e) {
      return OpenDualViewResult(result: false, message: e.message);
    }
  }

  @override
  Future<List<String>> getAvailablePackagesName() async {
    final List<dynamic> apps =
        await methodChannel.invokeMethod('getAvailablePackagesName');
    return apps.cast<String>();
  }
}

class OpenDualViewResult {
  final bool result;
  final String? message;

  OpenDualViewResult({required this.result, this.message = ""});

  @override
  String toString() => 'OpenDualViewResult(result: $result, message: $message)';
}
