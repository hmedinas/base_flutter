// lib/core/config/app_config.dart

class AppConfig {
  final AppInfoConfig app;
  final ApiConfig api;

  AppConfig({
    required this.app,
    required this.api,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      app: AppInfoConfig.fromJson(json['app'] ?? {}),
      api: ApiConfig.fromJson(json['api'] ?? {}),
    );
  }
}

class AppInfoConfig {
  final bool useMock;
  final bool useMockUser;
  final String version;
  final String nameApplication;
  final bool isMantenimiento;
  final bool viewLog;
  final String logLevel;

  AppInfoConfig({
    required this.useMock,
    required this.useMockUser,
    required this.version,
    required this.nameApplication,
    required this.isMantenimiento,
    required this.viewLog,
    required this.logLevel,
  });

  factory AppInfoConfig.fromJson(Map<String, dynamic> json) {
    return AppInfoConfig(
      useMock: json['useMock'] ?? false,
      useMockUser: json['useMockUser'] ?? false,
      version: json['version'] ?? '0.0.0',
      nameApplication: json['nameApplication'] ?? 'App',
      isMantenimiento: json['isMantenimiento'] ?? false,
      viewLog: json['viewLog'] ?? false,
      logLevel: json['logLevel'] ?? 'info',
    );
  }
}

class ApiConfig {
  final String baseUrl;
  final String authUrl;

  ApiConfig({
    required this.baseUrl,
    required this.authUrl,
  });

  factory ApiConfig.fromJson(Map<String, dynamic> json) {
    return ApiConfig(
      baseUrl: json['baseUrl'] ?? '',
      authUrl: json['authUrl'] ?? '',
    );
  }
}