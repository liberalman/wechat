export 'dart:io';
export 'dart:async';
export 'package:cached_network_image/cached_network_image.dart';
export '../config/const.dart';
export '../config/keys.dart';
export '../config/api.dart';
export '../ui/ui.dart';
export '../ui/bar/common_bar.dart';
export '../ui/button/common_button.dart';
export '../ui/dialog/show_toast.dart';
export '../ui/view/image_view.dart';
export '../common/check.dart';
export '../common/route.dart';
export './shared_util.dart';
export '../http/req.dart';
export '../tools/data/notice.dart';
export '../tools/data/data.dart';
export '../http/api.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

typedef Callback(data);

DefaultCacheManager cacheManager = new DefaultCacheManager();
