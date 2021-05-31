import 'package:networking/networking.dart';

class BaseApiHelper {
  static BaseApiHelper? _instance;

  BaseApiHelper._apiManager();
  static BaseApiHelper? getInstance() {
    if (_instance == null) {
      _instance = BaseApiHelper._apiManager();
    }

    return _instance;
  }

  final String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMGNiMzNmMy01OTFhLTRhMjUtYWFiYS1iZDA1Zjc5NmI1ZmIiLCJ1bmlxdWVfbmFtZSI6ImFkbWludXNlckBrb2NzaXN0ZW0uY29tLnRyIiwianRpIjoiY2FhY2M5MDEtMDI5ZC00YzU3LWExOTMtZmI4ZDc5NTEzYjNhIiwiZW1haWwiOiJhZG1pbnVzZXJAa29jc2lzdGVtLmNvbS50ciIsImdpdmVuX25hbWUiOiJTY290IiwiZmFtaWx5X25hbWUiOiJMYXdzb24iLCJleHAiOjE2MDA5Mzk5NDUsImlzcyI6Ikp3dFNlcnZlciIsImF1ZCI6Ikp3dFNlcnZlciJ9.kOntnbCwiOD0gFp9CTSG8dSbpuYdAzRfVQfHepH2eC4";

  Header get tokenHeader => Header("Authorization", "Bearer $_token");
}
