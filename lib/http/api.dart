import 'package:sprintf/sprintf.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../im/info_handle.dart';
import '../im/other/update_entity.dart';
import '../provider/global_model.dart';
import '../tools/wechat_flutter.dart';
import '../ui/dialog/update_dialog.dart';
import './req.dart';
import '../config/api.dart';

//post请求
POST_WITHOUT_LOGIN(String path, {Object formData}) async {
  var url = Uri.https(API.ROOT, API.PATH + path);
  var res = await http.post(url, body: formData);
  if (200 == res.statusCode)
    return res.body;
  else
    return sprintf("%d , %s", [res.statusCode, res.reasonPhrase]);
}

POST(String path, {Object formData}) async {
  final accessToken = await SharedUtil.getInstance().getString(Keys.accessToken);
  var url = Uri.https(API.ROOT, API.PATH + path);
  var res = await http.post(url, body: formData, headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "x-csrf-token": "_1550219423482_2238",
    "Authorization": "Bearer " + accessToken
  });
  if (200 == res.statusCode)
    return res.body;
  else
    return sprintf("%d , %s", [res.statusCode, res.reasonPhrase]);
}

//get请求
GET(String path) async {
  var url = Uri.https(API.ROOT, API.PATH + path);
  var res = await http.post(url);
  if (200 == res.statusCode)
    return res.body;
  else
    return sprintf("%d , %s", [res.statusCode, res.reasonPhrase]);
}

/// 随机头像 [Random avatar]
void postSuggestionWithAvatar(BuildContext context) async {
  final model = Provider.of<GlobalModel>(context);

  Req.getInstance().get(
    API.cat,
    (v) async {
      String avatarUrl = v['url'];
      final data = await setUsersProfileMethod(
        context,
        avatarStr: avatarUrl,
        nickNameStr: model.nickName,
        callback: (data) {},
      );

      if (data.toString().contains('ucc')) {
        showToast(context, '设置头像成功');
        model.avatar = avatarUrl;
        model.refresh();
        await SharedUtil.getInstance().saveString(Keys.avatar, avatarUrl);
      } else {
        showToast(context, '设置头像失败');
      }
    },
  );
}

/// 检查更新 [check update]
void updateApi(BuildContext context) async {
  if (Platform.isIOS) return;
  Req.getInstance().get(
    API.update,
    (v) async {
      final packageInfo = await PackageInfo.fromPlatform();

      UpdateEntity model = UpdateEntity.fromJson(v);
      int currentVersion = int.parse(removeDot(packageInfo.version));
      int netVersion = int.parse(removeDot(model.appVersion));
      if (currentVersion >= netVersion) {
        debugPrint('当前版本是最新版本');
        return;
      }
      showDialog(
          context: context,
          builder: (ctx2) {
            return UpdateDialog(
              version: model.appVersion,
              updateUrl: model.downloadUrl,
              updateInfo: model.updateInfo,
            );
          });
    },
  );
}

/// 上传头像 [uploadImg]
uploadImgApi(BuildContext context, base64Img, Callback callback) async {
  Req.getInstance().post(
    API.uploadImg,
    (v) {
      print('code::${v['code']}');
      print('URL::${v['result']['URL']}');
      if (v['code'] == 200) {
        callback(v['result']['URL']);
      } else {
        callback(null);
      }
    },
    params: {"image_base_64": base64Img},
  );
}
