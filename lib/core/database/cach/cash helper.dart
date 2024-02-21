




import 'package:shared_preferences/shared_preferences.dart';



class CachHelper
{
   static late SharedPreferences sharedPreferences;

  static init()async
  {
    sharedPreferences=await SharedPreferences.getInstance();
  }


/// set data into cachhelper
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

   // get data using specific key
   static bool? getData(
       {
         required String key,
       }
       )
   {
     return sharedPreferences.getBool(key);
   }

  // remove data using specific key

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

}
