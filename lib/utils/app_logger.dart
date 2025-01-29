import 'package:logger/logger.dart';

class AppLogger {
  late final Logger _logger; // 내부에서 사용할 Logger 객체

  // 싱글톤 인스턴스 생성
  static final AppLogger _instance = AppLogger._internal();
  AppLogger._internal() {
    _logger = Logger(
      filter: DevelopmentFilter(), // 개발 환경에서만 로그 활성화 //filter: CustomLogFilter(), // 모든 로그를 출력
      printer: PrettyPrinter(), // 출력 형식 설정
    );
  }

  // 외부에서 싱글톤 인스턴스를 접근
  factory AppLogger() {
    return _instance;
  }

  // Info 로그 메서드
  void info(String message) {
    _logger.i(message);
  }

  // Error 로그 메서드
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  // Debug 로그 메서드
  void debug(String message) {
    _logger.d(message);
  }

// 원하는 메서드 추가 가능
}

// 커스텀 LogFilter
class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // 모든 로그를 출력
    return true;
  }
}
