import 'package:encrypt/encrypt.dart' as encrypt;

class QRCodeController {
  String encryptString(String message) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(message, iv: iv);
    return encrypted.base64;
  }

  String decryptString(String encryptedMessage) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter
        .decrypt(encrypt.Encrypted.fromBase64(encryptedMessage), iv: iv);

    Map<String, String> parsedMessage = parseCode(decrypted, encryptedMessage);
    Duration difference =
        DateTime.now().difference(DateTime.parse(parsedMessage['dateTime']!));
    if (difference.inSeconds <= 15) {
      print("CONGRATS YOU CAN COME IN");
      return decrypted + "Can come in!";
    } else {
      print("OLD CODE, FAKE ASS HOE CANT COME IN BITCH");
      return decrypted + "Can't Come in!";
    }
  }

  Map<String, String> parseCode(String decrypted, String encryptedMessage) {
    Map<String, String> parsedMessage = {};
    String dictKey = "num_vac";
    String dictValue = "";
    for (var rune in decrypted.runes) {
      var character = String.fromCharCode(rune);
      if (character == "&") {
        parsedMessage[dictKey] = dictValue;
        dictKey = "name";
        dictValue = "";
      } else if (character == "+") {
        parsedMessage[dictKey] = dictValue;
        dictKey = "UUID";
        dictValue = "";
      } else if (character == "%") {
        parsedMessage[dictKey] = dictValue;
        dictKey = "dateTime";
        dictValue = "";
      } else {
        dictValue = dictValue + character;
      }
      parsedMessage[dictKey] = dictValue;
    }

    return parsedMessage;
  }
}
