import 'dart:convert';

DriverLicenseResponse driverLicenseResponseFromJson(String str) =>
    DriverLicenseResponse.fromJson(json.decode(str));

String driverLicenseResponseToJson(DriverLicenseResponse data) =>
    json.encode(data.toJson());

class DriverLicenseResponse {
  final bool success;
  final String message;
  final List<DriverMaster> data;

  DriverLicenseResponse({
    this.success = false,
    this.message = '',
    this.data = const [],
  });

  factory DriverLicenseResponse.fromJson(Map<String, dynamic> json) =>
      DriverLicenseResponse(
        success: json['success'] is bool ? json['success'] : false,
        message: json['message'] is String ? json['message'] : '',
        data: (json['data'] as List? ?? [])
            .map(
              (e) => DriverMaster.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class DriverMaster {
  final String drivLicNo;
  final String fName;
  final String lName;
  final String licExpDt;
  final String mobNo;
  final String adharNumber;
  final String erdat;
  final String ername;
  final String active;
  final String remark;
  final String tokenId;
  final String pAction;
  final String uniqueRowId;

  DriverMaster({
    this.drivLicNo = '',
    this.fName = '',
    this.lName = '',
    this.licExpDt = '',
    this.mobNo = '',
    this.adharNumber = '',
    this.erdat = '',
    this.ername = '',
    this.active = '',
    this.remark = '',
    this.tokenId = '',
    this.pAction = '',
    this.uniqueRowId = '',
  });

  factory DriverMaster.fromJson(Map<String, dynamic> json) {
    return DriverMaster(
      drivLicNo: json['DrivLicNo'] ?? '',
      fName: json['FName'] ?? '',
      lName: json['LName'] ?? '',
      licExpDt: json['LicExpDt'] ?? '',
      mobNo: json['MobNo'] ?? '',
      adharNumber: json['AdharNumber'] ?? '',
      erdat: json['Erdat'] ?? '',
      ername: json['Ername'] ?? '',
      active: json['Active'] ?? '',
      remark: json['Remark'] ?? '',
      tokenId: json['TokenId'] ?? '',
      pAction: json['PAction'] ?? '',
      uniqueRowId: json['uniqueRowId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DrivLicNo': drivLicNo,
      'FName': fName,
      'LName': lName,
      'LicExpDt': licExpDt,
      'MobNo': mobNo,
      'AdharNumber': adharNumber,
      'Erdat': erdat,
      'Ername': ername,
      'Active': active,
      'Remark': remark,
      'TokenId': tokenId,
      'PAction': pAction,
      'uniqueRowId': uniqueRowId,
    };
  }
}

class Metadata {
  final String id;
  final String uri;
  final String type;

  const Metadata({
    this.id = '',
    this.uri = '',
    this.type = '',
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json['id'] ?? '',
        uri: json['uri'] ?? '',
        type: json['type'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uri': uri,
        'type': type,
      };
}
