import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:head_up_ui/environment/app_constant.dart';
class Encryptor {
	static String descryptToken(String token) {
    final publicKey = RsaKeyHelper().parsePublicKeyFromPem(base64.decode(AppConstant.publicKey));
    final encryptedBytes = base64.decode(token);
    AsymmetricBlockCipher decryptor = RSAEngine()..init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    Uint8List decryptedBytes = _processInBlocks(decryptor, encryptedBytes);
    final decryptedToken = utf8.decode(decryptedBytes);
    print('Decrypted Token: $decryptedToken');
    return decryptedToken;
  }

  static Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
    final numBlocks = input.length ~/ engine.inputBlockSize;
    final output = <int>[];

    for (var i = 0; i <= numBlocks; i++) {
      final start = i * engine.inputBlockSize;
      final end = start + engine.inputBlockSize < input.length ? start + engine.inputBlockSize : input.length;
      output.addAll(engine.process(input.sublist(start, end)));
    }

    return Uint8List.fromList(output);
  }
}