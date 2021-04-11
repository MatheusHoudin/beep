import 'package:http/http.dart' as http;

class GoogleHttpClient extends http.BaseClient {
  Map<String, String> _headers;
  final http.Client _client = new http.Client();

  GoogleHttpClient(this._headers) : super();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
