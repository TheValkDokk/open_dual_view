
import 'open_dual_view_platform_interface.dart';

class OpenDualView {
  Future<String?> getPlatformVersion() {
    return OpenDualViewPlatform.instance.getPlatformVersion();
  }
}
