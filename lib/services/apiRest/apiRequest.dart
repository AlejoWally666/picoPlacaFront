import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<http.Response?> post(String url, Map body,
      {int timeout = 10}) async {
    try {
      http.Response valueWS = await http
          .post(Uri.parse(url),
              headers: {
                'Accept': 'application/json;',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(body))
          .timeout(
        Duration(
            seconds:
                timeout),
        onTimeout: () async {
          throw TimeoutException('Timeout de la solicitud');
        },
      );
      return valueWS;
    }  on TimeoutException catch (e) {
      return null;
    } catch (error) {
      return null;
    }
  }

  static Future<http.Response?> get(String url, {int timeout = 10}) async {
    try {
      http.Response valueWS = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(
        Duration(
            seconds:
            timeout),
        onTimeout: () async {
          throw TimeoutException('Timeout de la solicitud');
        },
      );
      return valueWS;
    } catch (error) {
      return null;
    }
  }

  static Future<http.Response?> delete(String url, {int timeout = 10}) async {
    try {
      http.Response valueWS = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(
        Duration(
            seconds:
            timeout),
        onTimeout: () async {
          throw TimeoutException('Timeout de la solicitud');
        },
      );
      return valueWS;
    } catch (error) {
      return null;
    }
  }


  static Future<http.Response?> put(String url, Map body,
      {int timeout = 10}) async {
    try {
      http.Response valueWS = await http
          .put(Uri.parse(url),
          headers: {
            'Accept': 'application/json;',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(body))
          .timeout(
        Duration(
            seconds:
            timeout),
        onTimeout: () async {
          throw TimeoutException('Timeout de la solicitud');
        },
      );
      return valueWS;
    }  on TimeoutException catch (e) {
      return null;
    } catch (error) {
      return null;
    }
  }
}
