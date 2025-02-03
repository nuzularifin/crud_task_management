import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logPrint('***** API Request ***** - started');

    printKV('URI', options.uri);
    printKV('METHOD', options.method);
    logPrint('*** HEADERS ***');
    options.headers.forEach((key, value) => printKV('- $key', value));
    logPrint('*** BODY ***');
    printAll(options.data ?? '');
    logPrint('***** API REQUEST ***** - ended');
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logPrint('*** API ERROR *** - started');
    logPrint('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      logPrint('STATUS_CODE: ${err.response?.statusCode?.toString()}');
    }
    logPrint('$err');
    if (err.response != null) {
      printKV('REDIRECT', err.response?.realUri ?? '');
      logPrint('BODY: ${err.response?.data ?? ''}');
      printAll(err.response?.data.toString());
    }

    logPrint('*** API ERROR *** - ended');
    return handler.next(err);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    logPrint('***** API RESPONSE ***** - started');
    printKV('URI', response.requestOptions.uri);
    printKV('STATUS_CODE', response.statusCode ?? '');
    printKV('REDIRECT', response.isRedirect);
    logPrint('***** BODY *****');
    printAll(response.data ?? '');
    logPrint('***** API RESPONSE ***** - ended');

    return handler.next(response);
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void logPrint(String s) {
    debugPrint(s);
  }
}
