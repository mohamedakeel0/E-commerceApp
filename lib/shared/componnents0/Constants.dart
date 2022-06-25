


import 'package:on_boarding/modules/login/login.dart';
import 'package:on_boarding/shared/componnents0/components.dart';
import 'package:on_boarding/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, Shoplogin());
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
dynamic token=CacheHelper.getData(key: 'token');