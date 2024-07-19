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
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
