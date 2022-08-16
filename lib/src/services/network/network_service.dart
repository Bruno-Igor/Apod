import 'package:dio/dio.dart';

import 'network_exception.dart';

class NetworkService {
  final String _baseUrl = 'https://api.nasa.gov';
  final String _apiKey = '1LP6Z54I00H54rd1xvOng8U6akYW1BcscclaTSRb';
  final String _apiPath = 'planetary/apod';

  final client = Dio();

  Future<Response> fetchData({int? imagesQuantity}) async {
    String url =
        '$_baseUrl/$_apiPath?api_key=$_apiKey&count=${imagesQuantity ?? 20}';
    print(url);
    try {
      var response = await client.get(url);
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == null) {
        throw NetworkException(message: 'Could not connect to the internet.');
      }
      throw NetworkException(
        statusCode: e.response?.statusCode,
        message: e.message,
      );
    }
  }
}
