import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:io';

import 'package:vaccheck/model/user_models/personal_user_model.dart';

class QRCodeController {
  String encryptString(String message) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(message, iv: iv);
    return encrypted.base64;
  }

  Map<String, dynamic> decryptString(String encryptedMessage) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    Map<String, dynamic> parsedMessage = {};
    Duration difference;
    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final decrypted = encrypter
          .decrypt(encrypt.Encrypted.fromBase64(encryptedMessage), iv: iv);
      parsedMessage = parseCode(decrypted, encryptedMessage);
      difference =
          DateTime.now().difference(DateTime.parse(parsedMessage['dateTime']));
      if (difference.inSeconds <= 15) {
        parsedMessage['isValidCode'] = 'true';
      } else {
        parsedMessage['isValidCode'] = 'false';
      }
    } catch (e) {
      print(e);
    }
    return parsedMessage;
  }

  Map<String, String> parseCode(String decrypted, String encryptedMessage) {
    Map<String, String> parsedMessage = {};
    String dictKey = "";
    String dictValue = "";
    for (var rune in decrypted.runes) {
      var character = String.fromCharCode(rune);
      if (character == "&") {
        dictKey = "numVac";
        parsedMessage[dictKey] = dictValue;
        dictValue = "";
      } else if (character == "+") {
        dictKey = "name";
        parsedMessage[dictKey] = dictValue;
        dictValue = "";
      } else if (character == "%") {
        dictKey = "UUID";
        parsedMessage[dictKey] = dictValue;
        dictValue = "";
      } else if (character == "^") {
        dictKey = "dateTime";
        parsedMessage[dictKey] = dictValue;
        dictValue = "";
      } else if (character == "*") {
        dictKey = "dateOfBirth";
        parsedMessage[dictKey] = dictValue;
        dictValue = "";
      } else {
        dictValue = dictValue + character;
      }
    }

    return parsedMessage;
  }
}
