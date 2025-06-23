import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:reqres_app/App/auth/login/loginUI.dart';
import 'package:reqres_app/App/auth/signUp/SignUpScreen.dart';
import 'package:reqres_app/network/model/result.dart';
import 'package:reqres_app/network/remote_data_source.dart';
import 'package:reqres_app/network/util/helper.dart';
import 'package:reqres_app/notificationCode/NotificationController.dart';
import 'package:reqres_app/widget/dismissKeyBoardView.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validEmail = false, validPassword = false, rememberMe = true;

  void goBack(context) {
    Helper().goBack();
  }

  void changeVaildEmail(bool value) {
    setState(() {
      validEmail = value;
    });
  }

  void changevalidPassword(bool value) {
    setState(() {
      validPassword = value;
    });
  }

  void changeRemember(bool value) {
    setState(() {
      rememberMe = value;
    });
  }

  // Future<String> getFirebaseMessagingToken() async {
  //   String firebaseAppToken = 'NA';
  //   if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
  //     try {
  //       firebaseAppToken =
  //           await AwesomeNotificationsFcm().requestFirebaseAppToken();
  //     } catch (exception) {
  //       print("exception");
  //       print('$exception');
  //     }
  //   } else {
  //     print('Firebase is not available on this project');
  //   }
  //   return firebaseAppToken;
  // }

  Future<void> showNotification() async {
    // var t = await getFirebaseMessagingToken();
    // print(t);
    NotificationController.createNewNotification();
    return;
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        // 'resource://drawable/res_app_icon',
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel_2',
              channelName: 'Basic notifications',
              importance: NotificationImportance.High,
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     // This is just a basic example. For real apps, you must show some
    //     // friendly dialog box before call the request method.
    //     // This is very important to not harm the user experience
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel_2',
      actionType: ActionType.Default,
      title: 'Hello World!',
      body: 'This is my first notification!',
    ));
  }

  Future<void> loginUser() async {
    showNotification();
    return;
    GetStorage box = GetStorage();
    if (_formKey.currentState!.validate()) {
      Helper().dismissKeyBoard(context);
      RemoteDataSource apiResponse = RemoteDataSource();
      var parameter = {
        "email": "eve.holt@reqres.in",
        "password": "cityslickasss"
      };
      var result = await apiResponse.userLogin(parameter);

      switch (result.status) {
        case LoadingStatus.loading:
          // Show loading spinner
          break;
        case LoadingStatus.success:
          final data = result.data!;
          box.write('token', data.token);
          Get.off(HomeScreen());
          break;
        case LoadingStatus.error:
          // Show error message: state.errorMessage
          break;
      }
    }
  }

  void createAccount() {
    Helper().dismissKeyBoard(context);
    Helper().goToPage(context: context, child: SignUpScreen());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyBoardView(
      child: LoginScreenUI(
          emailController: emailController,
          passwordController: passwordController,
          validEmail: validEmail,
          validPassword: validPassword,
          changeVaildEmail: changeVaildEmail,
          changevalidPassword: changevalidPassword,
          changeRemember: changeRemember,
          rememberMe: rememberMe,
          formKey: _formKey,
          createAccount: createAccount,
          loginUser: loginUser),
    );
  }
}
