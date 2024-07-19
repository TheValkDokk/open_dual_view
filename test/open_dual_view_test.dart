import 'package:flutter_test/flutter_test.dart';
import 'package:open_dual_view/open_dual_view.dart';
import 'package:open_dual_view/open_dual_view_platform_interface.dart';
import 'package:open_dual_view/open_dual_view_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOpenDualViewPlatform
    with MockPlatformInterfaceMixin
    implements OpenDualViewPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final OpenDualViewPlatform initialPlatform = OpenDualViewPlatform.instance;

  test('$MethodChannelOpenDualView is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOpenDualView>());
  });

  test('getPlatformVersion', () async {
    OpenDualView openDualViewPlugin = OpenDualView();
    MockOpenDualViewPlatform fakePlatform = MockOpenDualViewPlatform();
    OpenDualViewPlatform.instance = fakePlatform;

    expect(await openDualViewPlugin.getPlatformVersion(), '42');
  });
}
