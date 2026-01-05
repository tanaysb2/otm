import 'dart:convert';

VehicleNumberResponse vehicleNumberResponseFromJson(String str) =>
    VehicleNumberResponse.fromJson(json.decode(str));

String vehicleNumberResponseToJson(VehicleNumberResponse data) =>
    json.encode(data.toJson());

class VehicleNumberResponse {
  final bool success;
  final String message;
  final List<VehicleNumberModel> data;

  VehicleNumberResponse({
    this.success = false,
    this.message = '',
    this.data = const [],
  });

  factory VehicleNumberResponse.fromJson(Map<String, dynamic> json) =>
      VehicleNumberResponse(
        success: json['success'] is bool ? json['success'] : false,
        message: json['message'] is String ? json['message'] : '',
        data: (json['data'] as List? ?? [])
            .map(
              (e) => VehicleNumberModel.fromJson(
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

class VehicleNumberModel {
  final String truckNo;
  final String vsart;
  final String insurNumber;
  final String engnType;
  final String trkOwner;
  final String transCode;
  final String make;
  final String manfYear;
  final String fitExpDt;
  final String pucExpDt;
  final String rcExpDt;
  final String insurExpDt;
  final String erdat;
  final String ername;
  final String status;
  final String pTokenId;
  final String remarks;
  final String pAction;
  final String uniqueRowId;

  VehicleNumberModel({
    this.truckNo = '',
    this.vsart = '',
    this.insurNumber = '',
    this.engnType = '',
    this.trkOwner = '',
    this.transCode = '',
    this.make = '',
    this.manfYear = '',
    this.fitExpDt = '',
    this.pucExpDt = '',
    this.rcExpDt = '',
    this.insurExpDt = '',
    this.erdat = '',
    this.ername = '',
    this.status = '',
    this.pTokenId = '',
    this.remarks = '',
    this.pAction = '',
    this.uniqueRowId = '',
  });

  factory VehicleNumberModel.fromJson(Map<String, dynamic> json) {
    return VehicleNumberModel(
      truckNo: json['TruckNo'] ?? '',
      vsart: json['Vsart'] ?? '',
      insurNumber: json['InsurNumber'] ?? '',
      engnType: json['EngnType'] ?? '',
      trkOwner: json['TrkOwner'] ?? '',
      transCode: json['TransCode'] ?? '',
      make: json['Make'] ?? '',
      manfYear: json['ManfYear'] ?? '',
      fitExpDt: json['FitExpDt'] ?? '',
      pucExpDt: json['PucExpDt'] ?? '',
      rcExpDt: json['RcExpDt'] ?? '',
      insurExpDt: json['InsurExpDt'] ?? '',
      erdat: json['Erdat'] ?? '',
      ername: json['Ername'] ?? '',
      status: json['Status'] ?? '',
      pTokenId: json['PTokenId'] ?? '',
      remarks: json['Remarks'] ?? '',
      pAction: json['PAction'] ?? '',
      uniqueRowId: json['uniqueRowId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TruckNo': truckNo,
      'Vsart': vsart,
      'InsurNumber': insurNumber,
      'EngnType': engnType,
      'TrkOwner': trkOwner,
      'TransCode': transCode,
      'Make': make,
      'ManfYear': manfYear,
      'FitExpDt': fitExpDt,
      'PucExpDt': pucExpDt,
      'RcExpDt': rcExpDt,
      'InsurExpDt': insurExpDt,
      'Erdat': erdat,
      'Ername': ername,
      'Status': status,
      'PTokenId': pTokenId,
      'Remarks': remarks,
      'PAction': pAction,
      'uniqueRowId': uniqueRowId,
    };
  }
}
