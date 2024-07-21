import 'package:open_dual_view/open_dual_view_method_channel.dart';

import 'open_dual_view_platform_interface.dart';

class OpenDualView {
  /// Opens another application in dual view mode
  ///
  /// [packageName] is an optional parameter that specifies the package name
  /// of the application you want to open
  ///
  /// [uri] is an optional parameter representing the URI to be opened
  ///
  /// At least one of [packageName] or [uri] must be provided.
  ///
  /// Returns a [Future] that completes with an [OpenDualViewResult] indicating
  /// the success or failure of the operation.
  ///
  /// Example usage:
  /// ```dart
  /// OpenDualView.openInDualView(
  ///   packageName: "com.google.android.apps.maps",
  ///   uri: "google.streetview:cbll=46.414382,10.013988",
  /// );
  /// ```
  static Future<OpenDualViewResult> openInDualView({
    String? packageName,
    String? uri,
  }) async {
    return await OpenDualViewPlatform.instance.openInDualView(
      packageName,
      uri,
    );
  }

  static Future<List<String>> getAvailablePackagesName() async {
    return await OpenDualViewPlatform.instance.getAvailablePackagesName();
  }
}
