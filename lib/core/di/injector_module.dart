import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
// import 'package:dio_web_adapter/dio_web_adapter.dart';
@module
abstract class InjectorModule {
  @singleton
  Dio getDio() {
    final dio = Dio();
    dio.options.validateStatus = (int? status) {
      return true;
    };

    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";

    return dio;
  }
}
