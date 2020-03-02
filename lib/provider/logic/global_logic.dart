import 'package:wechat/provider/global_model.dart';
import 'package:wechat/tools/shared_util.dart';
import '../../config/keys.dart';

class GlobalLogic {
  final GlobalModel model;

  GlobalLogic(this.model);

  Future getCurrentLanguageCode() async {
    final list =
        await SharedUtil.getInstance().getStringList(Keys.currentLanguageCode);
    if (null == list)
      return ;
    if (list == model.currentLanguageCode)
      return ;
    model.currentLanguageCode = list;
  }

}