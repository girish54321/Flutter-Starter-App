// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:reqres_app/NotificationController.dart';
// import 'package:reqres_app/flavors.dart';
// import 'package:reqres_app/pages/my_home_page.dart';

// class ReqResApp extends StatefulWidget {
//   static final GlobalKey<NavigatorState> navigatorKey =
//       GlobalKey<NavigatorState>();

//   static const String name = 'Awesome Notifications - Example App';
//   static const Color mainColor = Colors.deepPurple;

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<ReqResApp> {
//   @override
//   void initState() {
//     // Only after at least the action method is set, the notification events are delivered
//     AwesomeNotifications().setListeners(
//         onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//         onNotificationCreatedMethod:
//             NotificationController.onNotificationCreatedMethod,
//         onNotificationDisplayedMethod:
//             NotificationController.onNotificationDisplayedMethod,
//         onDismissActionReceivedMethod:
//             NotificationController.onDismissActionReceivedMethod);

//     super.initState();
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // The navigator key is necessary to allow to navigate through static methods
//       navigatorKey: ReqResApp.navigatorKey,

//       title: ReqResApp.name,
//       color: ReqResApp.mainColor,

//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(
//                 builder: (context) => MyHomePage(title: ReqResApp.name));

//           case '/notification-page':
//             return MaterialPageRoute(builder: (context) {
//               final ReceivedAction receivedAction =
//                   settings.arguments as ReceivedAction;
//               return MyNotificationPage(receivedAction: receivedAction);
//             });

//           default:
//             assert(false, 'Page ${settings.name} not found');
//             return null;
//         }
//       },

//       theme: ThemeData(primarySwatch: Colors.deepPurple),
//     );
//   }
// }

// // class ReqResApp extends StatelessWidget {
// //   const ReqResApp({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     GetStorage box = GetStorage();
// //     GetInstance().put<SettingController>(SettingController());
// //     return DynamicColorBuilder(
// //       builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
// //         return GetMaterialApp(
// //           darkTheme: ThemeData(
// //             brightness: Brightness.dark,
// //             colorScheme: darkDynamic,
// //             scaffoldBackgroundColor: Colors.black,
// //           ),
// //           theme: ThemeData(
// //             brightness: Brightness.light,
// //             colorScheme: lightDynamic,
// //           ),
// //           localizationsDelegates: AppLocalizations.localizationsDelegates,
// //           supportedLocales: AppLocalizations.supportedLocales,
// //           title: 'Flutter Demo',
// //           getPages: [
// //             GetPage(
// //               name: '/',
// //               page: () {
// //                 return box.hasData('token')
// //                     ? _wrapWithBanner(HomeScreen())
// //                     : _wrapWithBanner(LoginScreen());
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// /// Adds banner to the [child] widget.
// Widget _wrapWithBanner(Widget child) {
//   return Banner(
//     child: child,
//     location: BannerLocation.topStart,
//     message: F.name,
//     color: Colors.green.withOpacity(0.6),
//     textStyle: const TextStyle(
//         fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
//     textDirection: TextDirection.ltr,
//   );
// }

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:reqres_app/App/auth/login/loginScreen.dart';
import 'package:reqres_app/l10n/app_localizations.dart';
import 'package:reqres_app/notificationCode/NotificationController.dart';
import 'package:reqres_app/state/settingsState.dart';
import 'package:dynamic_color/dynamic_color.dart';

class ReqResApp extends StatefulWidget {
  const ReqResApp({
    Key? key,
  }) : super(key: key);

  @override
  State<ReqResApp> createState() => _ReqResAppState();
}

class _ReqResAppState extends State<ReqResApp> {
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    GetInstance().put<SettingController>(SettingController());
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return GetMaterialApp(
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: darkDynamic,
            scaffoldBackgroundColor: Colors.black,
          ),
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: lightDynamic,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Flutter Demo',
          getPages: [
            GetPage(
              name: '/',
              page: () {
                return box.hasData('token') ? HomeScreen() : LoginScreen();
              },
            ),
          ],
        );
      },
    );
  }
}

class MyAppGirish extends StatefulWidget {
  const MyAppGirish({super.key});

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyAppGirish> createState() => _AppState();
}

class _AppState extends State<MyAppGirish> {
  // This widget is the root of your application.

  static const String routeHome = '/', routeNotification = '/notification-page';

  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    pageStack.add(MaterialPageRoute(
        builder: (_) =>
            const MyHomePage(title: 'Awesome Notifications Example App')));
    if (initialRouteName == routeNotification &&
        NotificationController.initialAction != null) {
      pageStack.add(MaterialPageRoute(
          builder: (_) => NotificationPage(
              receivedAction: NotificationController.initialAction!)));
    }
    return pageStack;
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
            builder: (_) =>
                const MyHomePage(title: 'Awesome Notifications Example App'));

      case routeNotification:
        ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return MaterialPageRoute(
            builder: (_) => NotificationPage(receivedAction: receivedAction));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notifications - Simple Example',
      navigatorKey: MyAppGirish.navigatorKey,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

///  *********************************************
///     HOME PAGE
///  *********************************************
///
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push the buttons below to create new notifications',
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            FloatingActionButton(
              heroTag: '1',
              onPressed: () => NotificationController.createNewNotification(),
              tooltip: 'Create New notification',
              child: const Icon(Icons.outgoing_mail),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () => NotificationController.scheduleNewNotification(),
              tooltip: 'Schedule New notification',
              child: const Icon(Icons.access_time_outlined),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: '3',
              onPressed: () => NotificationController.resetBadgeCounter(),
              tooltip: 'Reset badge counter',
              child: const Icon(Icons.exposure_zero),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: '4',
              onPressed: () => NotificationController.cancelNotifications(),
              tooltip: 'Cancel all notifications',
              child: const Icon(Icons.delete_forever),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

///  *********************************************
///     NOTIFICATION PAGE
///  *********************************************
class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
    required this.receivedAction,
  }) : super(key: key);

  final ReceivedAction receivedAction;

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  bool get hasTitle => widget.receivedAction.title?.isNotEmpty ?? false;
  bool get hasBody => widget.receivedAction.body?.isNotEmpty ?? false;
  bool get hasLargeIcon => widget.receivedAction.largeIconImage != null;
  bool get hasBigPicture => widget.receivedAction.bigPictureImage != null;

  double bigPictureSize = 0.0;
  double largeIconSize = 0.0;
  bool isTotallyCollapsed = false;
  bool bigPictureIsPredominantlyWhite = true;

  ScrollController scrollController = ScrollController();

  Future<bool> isImagePredominantlyWhite(ImageProvider imageProvider) async {
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    final dominantColor =
        paletteGenerator.dominantColor?.color ?? Colors.transparent;
    return dominantColor.computeLuminance() > 0.5;
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    print(widget.receivedAction.payload);
    if (hasBigPicture) {
      isImagePredominantlyWhite(widget.receivedAction.bigPictureImage!)
          .then((isPredominantlyWhite) => setState(() {
                bigPictureIsPredominantlyWhite = isPredominantlyWhite;
              }));
    }
  }

  void _scrollListener() {
    bool pastScrollLimit = scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 240;

    if (!hasBigPicture) {
      isTotallyCollapsed = true;
      return;
    }

    if (isTotallyCollapsed) {
      if (!pastScrollLimit) {
        setState(() {
          isTotallyCollapsed = false;
        });
      }
    } else {
      if (pastScrollLimit) {
        setState(() {
          isTotallyCollapsed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bigPictureSize = MediaQuery.of(context).size.height * .4;
    largeIconSize =
        MediaQuery.of(context).size.height * (hasBigPicture ? .16 : .2);

    if (!hasBigPicture) {
      isTotallyCollapsed = true;
    }

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: isTotallyCollapsed || bigPictureIsPredominantlyWhite
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            systemOverlayStyle:
                isTotallyCollapsed || bigPictureIsPredominantlyWhite
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light,
            expandedHeight: hasBigPicture
                ? bigPictureSize + (hasLargeIcon ? 40 : 0)
                : (hasLargeIcon)
                    ? largeIconSize + 10
                    : MediaQuery.of(context).padding.top + 28,
            backgroundColor: Colors.transparent,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              centerTitle: true,
              expandedTitleScale: 1,
              collapseMode: CollapseMode.pin,
              title: (!hasLargeIcon)
                  ? null
                  : Stack(children: [
                      Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: hasBigPicture
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: largeIconSize,
                              width: largeIconSize,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(largeIconSize)),
                                child: FadeInImage(
                                  placeholder: const NetworkImage(
                                      'https://cdn.syncfusion.com/content/images/common/placeholder.gif'),
                                  image: widget.receivedAction.largeIconImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              background: hasBigPicture
                  ? Padding(
                      padding: EdgeInsets.only(bottom: hasLargeIcon ? 60 : 20),
                      child: FadeInImage(
                        placeholder: const NetworkImage(
                            'https://cdn.syncfusion.com/content/images/common/placeholder.gif'),
                        height: bigPictureSize,
                        width: MediaQuery.of(context).size.width,
                        image: widget.receivedAction.bigPictureImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          if (hasTitle)
                            TextSpan(
                              text: widget.receivedAction.title!,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          if (hasBody)
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: hasTitle ? 16.0 : 0.0,
                                ),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                        widget.receivedAction.bodyWithoutHtml ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)),
                              ),
                            ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black12,
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Text(widget.receivedAction.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
