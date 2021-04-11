import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = new http.Client();

  HttpClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(this._headers));
  }

}