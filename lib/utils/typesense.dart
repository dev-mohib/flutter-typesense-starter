import 'package:typesense/typesense.dart';

const String _host = 'localhost';
const _protocol = Protocol.http;
const int _port = 8108;

final config = Configuration(
  // Api key
  'xyz',
  nodes: {
    Node(
      _protocol,
      _host,
      port: _port,
    ),
    Node.withUri(
      Uri(
        scheme: 'http',
        host: _host,
        port: _port,
      ),
    ),
    Node(
      _protocol,
      _host,
      port: _port,
    ),
  },
  numRetries: 3, // A total of 4 tries (1 original try + 3 retries)
  connectionTimeout: const Duration(seconds: 2),
);

final typesenseClient = Client(config);
