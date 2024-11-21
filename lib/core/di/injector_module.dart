import 'dart:io';

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
  @singleton
  String get baseUrl=>'http://192.168.0.3:3000/';
}
