class InvalidSeedException implements Exception {
  final String cause;
  InvalidSeedException(this.cause);
  @override
  String toString() {
    return cause;
  }
}

class TransactionFailedException implements Exception {
  final String cause;
  TransactionFailedException(this.cause);
  @override
  String toString() {
    return cause;
  }
}

class InvalidAddressException implements Exception {
  late String _message;

  InvalidAddressException([String message = 'Invalid InvalidAddress']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
