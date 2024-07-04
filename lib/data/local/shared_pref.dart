import 'package:nb_utils/nb_utils.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  bool get onBoarded => _sharedPrefs?.getBool('onBoarded') ?? false;
  set onBoarded(bool value) {
    _sharedPrefs?.setBool('onBoarded', value);
  }
}

final sharedPrefs = SharedPrefs();
