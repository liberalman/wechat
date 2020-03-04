class IPersonInfoEntity {
  int birthday;
  //String faceURL;
  String avatar;
  String identifier;
  int role;
  int gender;
  int level;
  String nickname;
  int language;
  IPersonInfoCustominfo customInfo;
  int allowType;

  IPersonInfoEntity(
      {this.birthday,
        this.avatar,
        this.identifier,
        this.role,
        this.gender,
        this.level,
        this.nickname,
        this.language,
        this.customInfo,
        this.allowType});

  IPersonInfoEntity.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    avatar = json['avatar']; // faceURL
    identifier = json['identifier'];
    role = json['role'];
    gender = json['gender'];
    level = json['level'];
    nickname = json['nickname'];
    language = json['language'];
    customInfo = json['customInfo'] != null
        ? new IPersonInfoCustominfo.fromJson(json['customInfo'])
        : null;
    allowType = json['allowType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['avatar'] = this.avatar;
    data['identifier'] = this.identifier;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['level'] = this.level;
    data['nickname'] = this.nickname;
    data['language'] = this.language;
    if (this.customInfo != null) {
      data['customInfo'] = this.customInfo.toJson();
    }
    data['allowType'] = this.allowType;
    return data;
  }
}

class IPersonInfoCustominfo {
  IPersonInfoCustominfo.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
