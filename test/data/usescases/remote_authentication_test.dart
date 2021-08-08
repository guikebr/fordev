import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  RemoteAuthentication({
    required this.httpClient,
    required this.url,
    required this.method,
  });

  final HttpClient httpClient;
  final String url;
  final String method;

  Future<void>? auth() async {
    await httpClient.request(url: url, method: method);
  }
}

abstract class HttpClient {
  Future<void>? request({required String url, required String method}) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    // System under test
    sut = RemoteAuthentication(
      httpClient: httpClient,
      url: url,
      method: 'post',
    );
  });

  test('Shoulf call HttpClient with correct URL', () async {
    await sut.auth();

    verify(httpClient.request(
      url: url,
      method: 'post',
    ));
  });
}
