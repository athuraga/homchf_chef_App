import 'package:dio/dio.dart';
import 'package:homchf_chef_side/utilities/prefConstatnt.dart';
import 'package:homchf_chef_side/utilities/preference.dart';

class ApiHeader {
  Dio dioData() {
    final dio = Dio(); // config your dio headers globally
    dio.options.headers["Authorization"] = "Bearer" +
        "  " +
        SharedPreferenceHelper.getString(
            Preferences.token); // config your dio headers globally
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;
    print('call api');
    return dio;
  }
}
