import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:reqres_app/App/auth/signUp/SignUpUI.dart';
import 'package:reqres_app/network/dataModel/LoginSuccess.dart';
import 'package:reqres_app/network/model/result.dart';
import 'package:reqres_app/network/remote_data_source.dart';
import 'package:reqres_app/network/util/helper.dart';
import 'package:reqres_app/widget/dismissKeyBoardView.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    print(value);
    setState(() {
      rememberMe = value;
    });
  }

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      Helper().dismissKeyBoard(context);
      Helper().showLoading();
      RemoteDataSource apiResponse = RemoteDataSource();
      var parameter = {"email": "eve.holt@reqres.in", "password": "cityslicka"};
      var result = await apiResponse.userLogin(parameter);

      switch (result.status) {
        case LoadingStatus.loading:
          // Show loading spinner
          break;
        case LoadingStatus.success:
          final data = result.data!;
          if (rememberMe) {
            GetStorage box = GetStorage();
            box.write('token', data.token);
            Get.offAll(HomeScreen());
          }
          break;
        case LoadingStatus.error:
          // Show error message: state.errorMessage
          break;
      }
    } else {
      // Helper().vibratPhone();
    }
  }

  void createAccount() {
    // Helper().dismissKeyBoard(context);
    // Helper().goToPage(context, SignUpScreen());
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
      child: SignUpScreenUI(
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
