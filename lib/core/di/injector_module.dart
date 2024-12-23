import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import 'package:dio_web_adapter/dio_web_adapter.dart';
@module
abstract class InjectorModule {
  @singleton
  Dio getDio() {
    final dio = Dio();

    dio.interceptors.add(PrettyDioLogger());

    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";

    return dio;
  }

  @Singleton()
  // String get baseUrl=>'http://192.168.3.24:3000/';
  String get baseUrl => kDebugMode?'http://192.168.0.17:3000/':'http://79.174.81.94:81/';
  // String get baseUrl=>'http://79.174.81.94:81/';
}
