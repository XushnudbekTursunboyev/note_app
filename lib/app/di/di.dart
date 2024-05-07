

import 'package:get_it/get_it.dart';
import 'package:note_app/app/data/sources/locale/hive_helper.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<HiveHelper>(HiveHelper());
}
