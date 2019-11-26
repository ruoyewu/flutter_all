import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class Encrypt {
  static const PUBLIC_KEY =
    "-----BEGIN PUBLIC KEY-----\n"
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDE+n0Mx/S7y9p5tln9G2LlXvFi\r"
    "iAfA8JSqowkMVuBY2Jg0nOoTYU0c6eULvRCZ0qBNwtybey6MFsfti/XPGUdaVVMg\r"
    "cl6zJFdz//6J+L0DxJWmwMUGmFwCAVrw3Sl+kqtTOTyIm5DcMD8BrKbzC/xJz7eI\r"
    "0P/qQyCCnZwjW6D1sQIDAQAB\n"
    "-----END PUBLIC KEY-----";

  static Encrypt _sInstance;

  static Encrypt get sInstance {
    if (_sInstance == null) {
      _sInstance = Encrypt();
    }
    return _sInstance;
  }

  Encrypter _encrpyter;

  Encrypt() {
    final key = RSAKeyParser().parse(PUBLIC_KEY);
    _encrpyter = Encrypter(RSA(publicKey: key, encoding: RSAEncoding.PKCS1));
  }

  String encrypt(String text) {
    final encrypted = _encrpyter.encrypt(base64Encode(utf8.encode(text)));
    return encrypted.base64;
  }
}