import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

/// DB 암호를 안전하게 가져오는 함수
Future<String> getDbPassword() async {
  // 저장된 키 가져오기
  var pw = await storage.read(key: 'dbPassword');

  // 없으면 새로 생성
  if (pw == null) {
    pw = DateTime.now().millisecondsSinceEpoch.toString(); // 랜덤 키 생성
    await storage.write(key: 'dbPassword', value: pw);
  }

  return pw;
}
