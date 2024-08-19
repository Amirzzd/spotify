
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefOperator {
  final SharedPreferences sharedPreferences;
  SharedPrefOperator(this.sharedPreferences,);

  /// theme mode
  saveThemeMode(bool isLight){
    sharedPreferences.setBool("isLight", isLight);
  }
  bool getThemeMode(){
    return sharedPreferences.getBool("isLight")??true;
  }

}
