class UserModel {
  Date? date;
  String? lName;
  String? fName;
  String? cDaily;
  bool? smoking;
  String? nYS;
  String? cPNumber;
  String? id;
  String? cPPrice;
  String? age;
  String? email;

  UserModel(
      {date,
      lName,
      fName,
      cDaily,
      smoking,
      nYS,
      cPNumber,
      id,
      cPPrice,
      age,
      email});

  UserModel.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
    lName = json['lName'];
    fName = json['fName'];
    cDaily = json['CDaily'];
    smoking = json['smoking'];
    nYS = json['NYS'];
    cPNumber = json['CPNumber'];
    id = json['id'];
    cPPrice = json['CPPrice'];
    age = json['age'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (date != null) {
      data['date'] = date!.toJson();
    }
    data['lName'] = lName;
    data['fName'] = fName;
    data['CDaily'] = cDaily;
    data['smoking'] = smoking;
    data['NYS'] = nYS;
    data['CPNumber'] = cPNumber;
    data['id'] = id;
    data['CPPrice'] = cPPrice;
    data['age'] = age;
    data['email'] = email;
    return data;
  }
}

class Date {
  String? months;
  String? days;
  String? years;

  Date({months, days, years});

  Date.fromJson(Map<String, dynamic> json) {
    months = json['months'];
    days = json['days'];
    years = json['years'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['months'] = months;
    data['days'] = days;
    data['years'] = years;
    return data;
  }

  String getDate() {
    return "$days - $months - $years";
  }
}
