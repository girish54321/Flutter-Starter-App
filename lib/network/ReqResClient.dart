import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:reqres_app/AppConst/AppConst.dart';
import 'util/nothing.dart';
import 'util/request_type.dart';
import 'util/request_type_exception.dart';

class ReqResClient {
  static const String _baseUrl = "https://reqres.in/api";
  final Client _client;
  GetStorage box = GetStorage();

  ReqResClient(this._client);

  Future<Response> request(
      {required RequestType requestType,
      required String path,
      Map<String, String>? params,
      dynamic parameter = Nothing}) async {
    if (kDebugMode) {
      print('🔵 [ReqResClient] Starting request...');
      print('📍 Request Type: $requestType');
      print('📍 Path: $path');
      print('📍 Params: $params');
      print('📍 Parameter: $parameter');
    }

    //* Check for the Token
    final hasToken = box.hasData(JWT_KEY);
    if (kDebugMode) {
      print('🔑 Token exists: $hasToken');
    }

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer pub_07e4aa1b3dc33b24a339a69ed1571736a858f33edaf9b647226d90d27bd1a82a',
      // if (hasToken) 'Authorization': 'Bearer ${box.read(JWT_KEY)}',
    };
    if (kDebugMode) {
      print('📋 Headers: $headers');
    }

    try {
      switch (requestType) {
        case RequestType.GET:
          var uri = _baseUrl +
              path +
              ((params != null) ? this.queryParameters(params) : "");
          if (kDebugMode) {
            print('🌐 GET URI: $uri');
          }

          final response = await _client.get(
              Uri.parse(
                uri,
              ),
              headers: headers);
          if (kDebugMode) {
            print('✅ GET Response Status: ${response.statusCode}');
            print('📦 GET Response Body: ${response.body}');
          }
          return response;

        case RequestType.POST:
          final url = "$_baseUrl/$path";
          final body = json.encode(parameter);
          if (kDebugMode) {
            print('🌐 POST URL: $url');
            print('📤 POST Body: $body');
          }

          final response =
              await _client.post(Uri.parse(url), headers: headers, body: body);
          if (kDebugMode) {
            print('✅ POST Response Status: ${response.statusCode}');
            print('📦 POST Response Body: ${response.body}');
          }
          return response;

        case RequestType.DELETE:
          final url = "$_baseUrl/$path";
          if (kDebugMode) {
            print('🌐 DELETE URL: $url');
          }

          final response = await _client.delete(Uri.parse(url));
          if (kDebugMode) {
            print('✅ DELETE Response Status: ${response.statusCode}');
            print('📦 DELETE Response Body: ${response.body}');
          }
          return response;

        default:
          if (kDebugMode) {
            print('❌ Unknown request type: $requestType');
          }
          throw RequestTypeNotFoundException(
              "The HTTP request mentioned is not found");
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ [ReqResClient] Error occurred:');
        print('Error: $e');
        print('StackTrace: $stackTrace');
      }
      rethrow;
    }
  }

  String queryParameters(Map<String, String> params) {
    if (kDebugMode) {
      print('🔧 Building query parameters: $params');
    }

    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      final query = '?${jsonString.query}';
      if (kDebugMode) {
        print('🔧 Query string: $query');
      }
      return query;
    }

    if (kDebugMode) {
      print('🔧 No query parameters');
    }
    return '';
  }
}
