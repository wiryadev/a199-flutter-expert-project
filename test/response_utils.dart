import 'dart:convert';

import 'package:http/http.dart' as http;

import 'json_reader.dart';

http.Response createUtf8Response(String jsonFile) {
  return http.Response.bytes(
    utf8.encode(readJson(jsonFile)),
    200,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}
