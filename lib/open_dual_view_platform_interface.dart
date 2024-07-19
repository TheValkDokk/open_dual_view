import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'open_dual_view_method_channel.dart';

abstract class OpenDualViewPlatform extends PlatformInterface {
  /// Constructs a OpenDualViewPlatform.
  OpenDualViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static OpenDualViewPlatform _instance = MethodChannelOpenDualView();

  /// The default instance of [OpenDualViewPlatform] to use.
  ///
  /// Defaults to [MethodChannelOpenDualView].
  static OpenDualViewPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OpenDualViewPlatform] when
  /// they register themselves.
  static set instance(OpenDualViewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
