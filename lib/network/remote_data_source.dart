import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:reqres_app/network/ReqResClient.dart';
import 'package:reqres_app/network/dataModel/LoginSuccess.dart';
import 'package:reqres_app/network/model/result.dart';
import 'package:reqres_app/network/model/userListModal.dart';
import 'package:reqres_app/network/util/api_path.dart';
import 'package:reqres_app/network/util/request_type.dart';
import 'package:reqres_app/widget/DialogHelper.dart';

class RemoteDataSource {
  ReqResClient client = ReqResClient(Client());

  Future<LoadingState<LoginSuccess>> userLogin(parameter) async {
    try {
      final response = await client.request(
        requestType: RequestType.POST,
        path: APIPathHelper.getValue(APIPath.login),
        parameter: parameter,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = LoginSuccess.fromJson(json.decode(response.body));
        return LoadingState.success(data);
      } else {
        DialogHelper.showErrorDialog(description: response.body.toString());
        return LoadingState.error("Error code: ${response.statusCode}");
      }
    } catch (error) {
      DialogHelper.showErrorDialog(description: "Something went wrong! $error");
      return LoadingState.error("Something went wrong! $error");
    }
  }

  Future<LoadingState<UserListResponse?>> userList() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET,
          path: APIPathHelper.getValue(APIPath.users),
          params: {"per_page": "50"});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = UserListResponse.fromJson(json.decode(response.body));
        return LoadingState.success(data);
      } else {
        DialogHelper.showErrorDialog(description: response.body.toString());
        return LoadingState.error("Error code: ${response.statusCode}");
      }
    } catch (error) {
      DialogHelper.showErrorDialog(description: "Something went wrong! $error");
      return LoadingState.error("Something went wrong! $error");
    }
  }
}
