import 'package:flutter_template/bootstrap.dart';
import 'package:flutter_template/core/configs/app_config.dart';
import 'package:flutter_template/core/shared/utils/app_logger.dart';

void main() {
  AppLogger.d('[ENV VARIABLES]\n ${AppConfig()}');
  bootstrap();
}
