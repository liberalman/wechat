/// 字符串不为空
bool strNoEmpty(String value) {
  if (value == null)
    return false;

  return value.trim().isNotEmpty;
}

///判断List是否为空
bool listNoEmpty(List list) {
  if (list == null)
    return false;
  if (list.length == 0)
    return false;
  return true;
}

/// 判断是否网络
bool isNetWorkImg(String img) {
  return null != img && (img.startsWith('http') || img.startsWith('https'));
}

/// 判断是否资源图片
bool isAssetsImg(String img) {
  return null != img && img.startsWith('asset') || img.startsWith('assets');
}

/// 字符串不为空
bool mapNoEmpty(Map value) {
  if (value == null) return false;
  return value.isNotEmpty;
}

///去除小数点
String removeDot(v) {
  String vStr = v.toString().replaceAll('.', '');

  return vStr;
}