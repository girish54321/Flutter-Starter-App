# Flutter Starter with Flavors ❤️

## Welcome

Welcome to our Flutter starter repo! This repo includes a variety of core features to help you get started building a top-quality mobile app.

## Flavor builds

Need to create different versions of your app for different markets or audiences? No problem! This starter repo includes support for flavor builds, so you can easily create unique versions of your app with their own branding, assets, and configurations.

## GetX

GetX is a powerful and lightweight state management library for Flutter apps. We've included it in this starter repo to help you manage the state of your app in a consistent and efficient manner.

Get started building your dream app today with this Flutter starter repo!

## Light Mode

<img width="1604"  src="appimages/banner_light.png?raw=true">

## Dark Mode

<img width="1604"  src="appimages/banner_dark.png?raw=true">

## Run Locally

Clone the project

```bash
  git clone https://github.com/girish54321/Flutter-Starter-App.git
```

```bash
  flutter build apk --release -t lib/main-reqres_dev.dart --flavor reqres_dev
```

### Flutter Doctor

```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.27.1, on macOS 15.2 24C101 darwin-x64, locale
    en-IN)
[!] Android toolchain - develop for Android devices (Android SDK version 35.0.0)
    ✗ cmdline-tools component is missing
      Run `path/to/sdkmanager --install "cmdline-tools;latest"`
      See https://developer.android.com/studio/command-line for more details.
    ✗ Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/to/macos-android-setup for more details.
[✓] Xcode - develop for iOS and macOS (Xcode 16.1)
[✗] Chrome - develop for the web (Cannot find Chrome executable at
    /Applications/Google Chrome.app/Contents/MacOS/Google Chrome)
    ! Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.
[✓] Android Studio (version 2024.2)
[✓] VS Code (version 1.96.2)
[✓] Connected device (2 available)
[✓] Network resources

! Doctor found issues in 2 categories.
```

### Android Stodio

```
Android Studio Ladybug Feature Drop | 2024.2.2
Build #AI-242.23726.103.2422.12816248, built on December 18, 2024
Runtime version: 21.0.4+-12422083-b607.1 x86_64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
Toolkit: sun.lwawt.macosx.LWCToolkit
macOS 15.2
GC: G1 Young Generation, G1 Concurrent GC, G1 Old Generation
Memory: 4096M
Cores: 16
Metal Rendering is ON
Registry:
  ide.experimental.ui=true
  i18n.locale=
```

### Xcode

`Version 16.1 (16B40)`

## Create APK

```bash
  flutter build apk --release -t lib/main-reqres.dart --flavor reqres
```

## Change App Icon

```bash
  flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-reqres.yaml
```

React, React native, Redux

If you find my work useful, please consider supporting me by buying me a coffee!

Your support helps me continue to develop and maintain this project.

Thank you!

<a href="https://www.buymeacoffee.com/girishparaa" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
