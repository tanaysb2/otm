// transporter_response.dart

class TransporterResponse {
  final bool success;
  final String message;
  final List<TransporterMaster> data;

  TransporterResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransporterResponse.fromJson(Map<String, dynamic> json) {
    return TransporterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => TransporterMaster.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class TransporterMaster {
  final Metadata metadata;
  final String transCode;
  final String trnasName;
  final String corpId;
  final String scac;
  final String corpName;
  final String active;
  final String tempFlag;
  final String gstMechanism;
  final String amtSecurity;
  final String gstNumber;
  final String typeSecurity;
  final String compCode;
  final String validDate;
  final String pan;
  final String zone1;
  final String email;
  final String mobile;
  final String erdat;
  final String rootTrans;
  final String grade;
  final String pTokenId;
  final String pUserId;
  final String uniqueRowId;

  TransporterMaster({
    required this.metadata,
    required this.transCode,
    required this.trnasName,
    required this.corpId,
    required this.scac,
    required this.corpName,
    required this.active,
    required this.tempFlag,
    required this.gstMechanism,
    required this.amtSecurity,
    required this.gstNumber,
    required this.typeSecurity,
    required this.compCode,
    required this.validDate,
    required this.pan,
    required this.zone1,
    required this.email,
    required this.mobile,
    required this.erdat,
    required this.rootTrans,
    required this.grade,
    required this.pTokenId,
    required this.pUserId,
    required this.uniqueRowId,
  });

  factory TransporterMaster.fromJson(Map<String, dynamic> json) {
    return TransporterMaster(
      metadata:
          Metadata.fromJson(json['__metadata'] as Map<String, dynamic>? ?? {}),
      transCode: json['TransCode'] ?? '',
      trnasName: json['TrnasName'] ?? '',
      corpId: json['CorpId'] ?? '',
      scac: json['Scac'] ?? '',
      corpName: json['CorpName'] ?? '',
      active: json['Active'] ?? '',
      tempFlag: json['TempFlag'] ?? '',
      gstMechanism: json['GstMechanism'] ?? '',
      amtSecurity: json['AmtSecurity'] ?? '0.000',
      gstNumber: json['GstNumber'] ?? '',
      typeSecurity: json['TypeSecurity'] ?? '',
      compCode: json['CompCode'] ?? '',
      validDate: json['ValidDate'] ?? '0000-00-00',
      pan: json['Pan'] ?? '',
      zone1: json['Zone1'] ?? '',
      email: json['Email'] ?? '',
      mobile: json['Mobile'] ?? '',
      erdat: json['Erdat'] ?? '0000-00-00',
      rootTrans: json['RootTrans'] ?? '',
      grade: json['Grade'] ?? '',
      pTokenId: json['PTokenId'] ?? '',
      pUserId: json['PUserId'] ?? '',
      uniqueRowId: json['uniqueRowId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '__metadata': metadata.toJson(),
      'TransCode': transCode,
      'TrnasName': trnasName,
      'CorpId': corpId,
      'Scac': scac,
      'CorpName': corpName,
      'Active': active,
      'TempFlag': tempFlag,
      'GstMechanism': gstMechanism,
      'AmtSecurity': amtSecurity,
      'GstNumber': gstNumber,
      'TypeSecurity': typeSecurity,
      'CompCode': compCode,
      'ValidDate': validDate,
      'Pan': pan,
      'Zone1': zone1,
      'Email': email,
      'Mobile': mobile,
      'Erdat': erdat,
      'RootTrans': rootTrans,
      'Grade': grade,
      'PTokenId': pTokenId,
      'PUserId': pUserId,
      'uniqueRowId': uniqueRowId,
    };
  }
}

class Metadata {
  final String id;
  final String uri;
  final String type;

  Metadata({
    required this.id,
    required this.uri,
    required this.type,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      id: json['id'] ?? '',
      uri: json['uri'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uri': uri,
      'type': type,
    };
  }
}

// Usage Example:
// 
// import 'dart:convert';
// 
// void main() {
//   String jsonString = '...'; // Your JSON string
//   
//   final jsonData = jsonDecode(jsonString);
//   final response = TransporterResponse.fromJson(jsonData);
//   
//   print('Success: ${response.success}');
//   print('Total transporters: ${response.data.length}');
//   
//   for (var transporter in response.data) {
//     print('${transporter.transCode}: ${transporter.trnasName}');
//   }
// }