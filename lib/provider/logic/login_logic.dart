import '../../tools/shared_util.dart';
import '../../config/keys.dart';
import '../login_model.dart';

class LoginLogic {
  final LoginModel _model;

  LoginLogic(this._model);

  ///获取当前选择的地区号码
  Future getArea() async {
    final area = await SharedUtil.getInstance().getString(Keys.area);
    if (null == area)
      return;
    if (area == _model.area)
      return;
    _model.area = area;
  }
}
