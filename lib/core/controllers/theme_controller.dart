import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:comunidadesucv/config/themes/theme.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _isLightTheme = false.obs;

  bool get isLightTheme => _isLightTheme.value;

  @override
  void onInit() {
    super.onInit();
    _isLightTheme.value = _box.read('isLightTheme') ?? false;
    AppTheme.isLightTheme = _isLightTheme.value;
  }

  void toggleTheme() {
    _isLightTheme.value = !_isLightTheme.value;
    _box.write('isLightTheme', _isLightTheme.value);
    AppTheme.isLightTheme = _isLightTheme.value;
    Get.changeTheme(AppTheme.getTheme());
  }
}
