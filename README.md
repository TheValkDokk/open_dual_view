# `open_dual_view`

The `open_dual_view` Flutter package provides functionality to open other applications in dual view mode on Android devices. Dual view mode allows users to view and interact with two apps simultaneously on the screen.

## Features

- Open applications in dual view mode.
- Launch applications by package name or URI scheme.

## Getting Started

To use the `open_dual_view` package in your Flutter application, follow these steps:

### 1. Add Dependency

Add `open_dual_view` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  open_dual_view: ^1.0.0  # Check for the latest version on pub.dev
```

### 2. Import the Package

Import the `open_dual_view` package in your Dart code:

```dart
import 'package:open_dual_view/open_dual_view.dart';
```

### 3. Usage

You can open an application in dual view mode by specifying either the package name or the URI. Note that at least one of these parameters must be provided.

```dart
import 'package:open_dual_view/open_dual_view.dart';

Future<void> openAppInDualView() async {
  try {
    // Open an application by its package name
    await OpenDualView.openInDualView(
      packageName: 'com.example.myapp',
    );

    // Alternatively, open an application or content via URI
    await OpenDualView.openInDualView(
      uri: 'example://content',
    );
  } catch (e) {
    print('Failed to open application in dual view: $e');
  }
}
```

***Developement***
Use getAvailablePackagesName to retrieve the list of available package name that of apps that can be open when using packageName parameter, if not check [Known Issues and Recommendations]() below

### 4. Platform Support

The `open_dual_view` package is designed to work on Android devices that support dual view mode, starting from Android SDK 30 (Android 11) and up. 

- **Minimum SDK Version**: This package requires a minimum SDK version of 30 (Android 11). Make sure your `android/app/build.gradle` file reflects this requirement:

  ```gradle
  android {
      defaultConfig {
          minSdkVersion 30
      }
  }
  ```

**Important Notes:**

- **Android 11 (API level 30)** and later versions introduced changes in how apps can query other apps. The `<queries>` element in the `AndroidManifest.xml` is used to declare which packages your app intends to query. Ensure that your app includes the necessary `<queries>` element to specify the packages you need to interact with.

- **Permissions**: The `QUERY_ALL_PACKAGES` permission is not used in this package to avoid broad access to all installed apps. Instead, only specific packages are queried using the `<queries>` element.

Ensure that your `AndroidManifest.xml` is configured correctly with the `<queries>` element if you want to open app using packageName (This is not reliable because of [Package visibility filtering on Android](https://developer.android.com/training/package-visibility) ):

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="your.package.name">

    <application>
    </application>
        <!-- Declare the packages you want to query -->
        <queries>
            <package android:name="com.twitter.android" />
            <!-- Add more packages as needed -->
        </queries>
</manifest>
```

**Known Issues and Recommendations:**

- **Package Name Limitations**: Opening apps by package name may not always work as expected due to restrictions or specific configurations of the target apps. If you encounter issues with using package names, consider using URIs instead.

- **Using URI**: If you are trying to open apps that support deep linking via URI schemes, using URIs can provide a more reliable method. Make sure the target app supports the URI scheme you are using.

- **Intent Context for Apps You Author**: If you are the author of the target app, consider implementing intent handling to guarantee that the app opens correctly and deep linking functions as intended.

### Contributing

We welcome contributions to the `open_dual_view` package!

1. **Report Issues**: If you encounter any bugs or issues with the package, please [open an issue](https://github.com/TheValkDokk/open_dual_view/issues) on GitHub. Provide as much detail as possible, including steps to reproduce the problem and any relevant logs or screenshots.

2. **Suggest Features**: If you have ideas for new features or improvements, feel free to [submit a feature request](https://github.com/TheValkDokk/open_dual_view). Describe your idea and explain how it would enhance the package.

**Disclaimer**: The functionality provided by the `open_dual_view` package can be done using the [android_intent_plus](https://pub.dev/packages/android_intent_plus) package. The `open_dual_view` package currently focuses on dual view mode functionality and provides a unique interface for this purpose. In the future, as Android APIs evolve and offer more control, we plan to implement more distinctive features in this package.


For more information or if you have any questions, please feel free to reach out.

---

Happy coding!
