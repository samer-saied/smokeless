class AdviceModel {
  String? date;
  String? data;
  String? by;
  String? index;
  String? lang;

  AdviceModel({date, data, by, index, lang});

  AdviceModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    data = json['data'];
    by = json['by'];
    index = json['index'].toString();
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date'] = date;
    data['data'] = data;
    data['by'] = by;
    data['index'] = index;
    data['lang'] = lang;
    return data;
  }
}
