/// OData `__metadata` block on beat detail rows.
class BeatDtlMetadata {
  final String? id;
  final String? uri;
  final String? type;

  BeatDtlMetadata({this.id, this.uri, this.type});

  factory BeatDtlMetadata.fromJson(Map<String, dynamic> json) {
    return BeatDtlMetadata(
      id: _str(json['id']),
      uri: _str(json['uri']),
      type: _str(json['type']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uri': uri,
        'type': type,
      };
}

class RouteTertiaryModel {
  final BeatDtlMetadata? metadata;
  final String? dayCd;
  final String? pickDate;
  final String? dayNm;
  final String? serviceCd;
  final String? matnr;
  final String? routeId;
  final String? maktx;
  final String? serName;
  final String? mobNo;
  final String? lat;
  final String? tripNo;
  /// SAP field `Long` (longitude); not Dart's `long` keyword.
  final String? geoLong;
  final String? tripId;
  final String? ertype;
  final String? distLoc;
  final String? yMail;
  final String? lifnr;
  final String? pickType;
  final String? routeCd;
  final String? routeName;
  final String? beatCutTm;
  final String? pSegm;
  final String? beatOutTm;
  final String? routeType;
  final String? beatCd;
  final String? locCd;
  final String? noBeatWk;
  final String? beatFreq;
  final String? minTte;
  final String? maxTtr;
  final String? dailyBeatFreq;
  final String? beatDistance;
  final String? minVechSize;
  final String? remark;
  final String? erdat;
  final String? ername;
  final String? locName;
  final String? kunnr;
  final String? custName;
  final String? rtDate;
  final String? rtTime;
  final String? truckNo;
  final String? drivLicNo;
  final String? make;
  final String? makeTte;
  final String? actTte;
  final String? outDt;
  final String? outTm;
  final String? outBy;
  final String? rcptFlg;
  final String? rctpDt;
  final String? rcptTm;
  final String? clsFlg;
  final String? cldMode;
  final String? invNo;
  final String? status;
  final String? tte;
  final String? invDt;
  final String? fkart;
  final String? ewayBill;
  final String? ewayDt;
  final String? ewayTm;
  final String? canFlag;
  final String? scanStatus;
  final String? statsDs;
  final String? pType;
  final String? pAction;
  final String? oth1;
  final String? oth2;
  final String? oth3;
  final String? oth4;
  final String? oth5;
  final String? othN1;
  final String? othN2;
  final String? othN3;
  final String? othDt1;
  final String? othDt2;
  final String? othDt3;
  final String? otjDt4;
  final String? oth6;
  final String? oth7;
  final String? billQty;
  final String? billTte;
  final String? invCnt;
  final String? dlrCnt;
  final String? postCd;
  final String? postMsg;
  final String? terrCode;
  final String? terrName;
  final String? scanQty;
  final String? accGrp;
  final String? message;
  final String? retrunCode;
  final String? tokenId;
  final String? uniqueRowId;

  RouteTertiaryModel({
    this.metadata,
    this.dayCd,
    this.pickDate,
    this.dayNm,
    this.serviceCd,
    this.matnr,
    this.routeId,
    this.maktx,
    this.serName,
    this.mobNo,
    this.lat,
    this.tripNo,
    this.geoLong,
    this.tripId,
    this.ertype,
    this.distLoc,
    this.yMail,
    this.lifnr,
    this.pickType,
    this.routeCd,
    this.routeName,
    this.beatCutTm,
    this.pSegm,
    this.beatOutTm,
    this.routeType,
    this.beatCd,
    this.locCd,
    this.noBeatWk,
    this.beatFreq,
    this.minTte,
    this.maxTtr,
    this.dailyBeatFreq,
    this.beatDistance,
    this.minVechSize,
    this.remark,
    this.erdat,
    this.ername,
    this.locName,
    this.kunnr,
    this.custName,
    this.rtDate,
    this.rtTime,
    this.truckNo,
    this.drivLicNo,
    this.make,
    this.makeTte,
    this.actTte,
    this.outDt,
    this.outTm,
    this.outBy,
    this.rcptFlg,
    this.rctpDt,
    this.rcptTm,
    this.clsFlg,
    this.cldMode,
    this.invNo,
    this.status,
    this.tte,
    this.invDt,
    this.fkart,
    this.ewayBill,
    this.ewayDt,
    this.ewayTm,
    this.canFlag,
    this.scanStatus,
    this.statsDs,
    this.pType,
    this.pAction,
    this.oth1,
    this.oth2,
    this.oth3,
    this.oth4,
    this.oth5,
    this.othN1,
    this.othN2,
    this.othN3,
    this.othDt1,
    this.othDt2,
    this.othDt3,
    this.otjDt4,
    this.oth6,
    this.oth7,
    this.billQty,
    this.billTte,
    this.invCnt,
    this.dlrCnt,
    this.postCd,
    this.postMsg,
    this.terrCode,
    this.terrName,
    this.scanQty,
    this.accGrp,
    this.message,
    this.retrunCode,
    this.tokenId,
    this.uniqueRowId,
  });

  factory RouteTertiaryModel.fromJson(Map<String, dynamic> json) {
    return RouteTertiaryModel(
      metadata: json['__metadata'] != null
          ? BeatDtlMetadata.fromJson(
              Map<String, dynamic>.from(json['__metadata'] as Map),
            )
          : null,
      dayCd: _str(json['DayCd']),
      pickDate: _str(json['PickDate']),
      dayNm: _str(json['DayNm']),
      serviceCd: _str(json['ServiceCd']),
      matnr: _str(json['Matnr']),
      routeId: _str(json['RouteId']),
      maktx: _str(json['Maktx']),
      serName: _str(json['SerName']),
      mobNo: _str(json['MobNo']),
      lat: _str(json['Lat']),
      tripNo: _str(json['TripNo']),
      geoLong: _str(json['Long']),
      tripId: _str(json['TripId']),
      ertype: _str(json['Ertype']),
      distLoc: _str(json['DistLoc']),
      yMail: _str(json['YMail']),
      lifnr: _str(json['Lifnr']),
      pickType: _str(json['PickType']),
      routeCd: _str(json['RouteCd']),
      routeName: _str(json['RouteName']),
      beatCutTm: _str(json['BeatCutTm']),
      pSegm: _str(json['PSegm']),
      beatOutTm: _str(json['BeatOutTm']),
      routeType: _str(json['RouteType']),
      beatCd: _str(json['BeatCd']),
      locCd: _str(json['LocCd']),
      noBeatWk: _str(json['NoBeatWk']),
      beatFreq: _str(json['BeatFreq']),
      minTte: _str(json['MinTte']),
      maxTtr: _str(json['MaxTtr']),
      dailyBeatFreq: _str(json['DailyBeatFreq']),
      beatDistance: _str(json['BeatDistance']),
      minVechSize: _str(json['MinVechSize']),
      remark: _str(json['Remark']),
      erdat: _str(json['Erdat']),
      ername: _str(json['Ername']),
      locName: _str(json['LocName']),
      kunnr: _str(json['Kunnr']),
      custName: _str(json['CustName']),
      rtDate: _str(json['RtDate']),
      rtTime: _str(json['RtTime']),
      truckNo: _str(json['TruckNo']),
      drivLicNo: _str(json['DrivLicNo']),
      make: _str(json['Make']),
      makeTte: _str(json['MakeTte']),
      actTte: _str(json['ActTte']),
      outDt: _str(json['OutDt']),
      outTm: _str(json['OutTm']),
      outBy: _str(json['OutBy']),
      rcptFlg: _str(json['RcptFlg']),
      rctpDt: _str(json['RctpDt']),
      rcptTm: _str(json['RcptTm']),
      clsFlg: _str(json['ClsFlg']),
      cldMode: _str(json['CldMode']),
      invNo: _str(json['InvNo']),
      status: _str(json['Status']),
      tte: _str(json['Tte']),
      invDt: _str(json['InvDt']),
      fkart: _str(json['Fkart']),
      ewayBill: _str(json['EwayBill']),
      ewayDt: _str(json['EwayDt']),
      ewayTm: _str(json['EwayTm']),
      canFlag: _str(json['CanFlag']),
      scanStatus: _str(json['ScanStatus']),
      statsDs: _str(json['StatsDs']),
      pType: _str(json['PType']),
      pAction: _str(json['PAction']),
      oth1: _str(json['Oth1']),
      oth2: _str(json['Oth2']),
      oth3: _str(json['Oth3']),
      oth4: _str(json['Oth4']),
      oth5: _str(json['Oth5']),
      othN1: _str(json['OthN1']),
      othN2: _str(json['OthN2']),
      othN3: _str(json['OthN3']),
      othDt1: _str(json['OthDt1']),
      othDt2: _str(json['OthDt2']),
      othDt3: _str(json['OthDt3']),
      otjDt4: _str(json['OtjDt4']),
      oth6: _str(json['Oth6']),
      oth7: _str(json['Oth7']),
      billQty: _str(json['BillQty']),
      billTte: _str(json['BillTte']),
      invCnt: _str(json['InvCnt']),
      dlrCnt: _str(json['DlrCnt']),
      postCd: _str(json['PostCd']),
      postMsg: _str(json['PostMsg']),
      terrCode: _str(json['TerrCode']),
      terrName: _str(json['TerrName']),
      scanQty: _str(json['ScanQty']),
      accGrp: _str(json['AccGrp']),
      message: _str(json['Message']),
      retrunCode: _str(json['RetrunCode']),
      tokenId: _str(json['TokenId']),
      uniqueRowId: _str(json['uniqueRowId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (metadata != null) '__metadata': metadata!.toJson(),
      'DayCd': dayCd,
      'PickDate': pickDate,
      'DayNm': dayNm,
      'ServiceCd': serviceCd,
      'Matnr': matnr,
      'RouteId': routeId,
      'Maktx': maktx,
      'SerName': serName,
      'MobNo': mobNo,
      'Lat': lat,
      'TripNo': tripNo,
      'Long': geoLong,
      'TripId': tripId,
      'Ertype': ertype,
      'DistLoc': distLoc,
      'YMail': yMail,
      'Lifnr': lifnr,
      'PickType': pickType,
      'RouteCd': routeCd,
      'RouteName': routeName,
      'BeatCutTm': beatCutTm,
      'PSegm': pSegm,
      'BeatOutTm': beatOutTm,
      'RouteType': routeType,
      'BeatCd': beatCd,
      'LocCd': locCd,
      'NoBeatWk': noBeatWk,
      'BeatFreq': beatFreq,
      'MinTte': minTte,
      'MaxTtr': maxTtr,
      'DailyBeatFreq': dailyBeatFreq,
      'BeatDistance': beatDistance,
      'MinVechSize': minVechSize,
      'Remark': remark,
      'Erdat': erdat,
      'Ername': ername,
      'LocName': locName,
      'Kunnr': kunnr,
      'CustName': custName,
      'RtDate': rtDate,
      'RtTime': rtTime,
      'TruckNo': truckNo,
      'DrivLicNo': drivLicNo,
      'Make': make,
      'MakeTte': makeTte,
      'ActTte': actTte,
      'OutDt': outDt,
      'OutTm': outTm,
      'OutBy': outBy,
      'RcptFlg': rcptFlg,
      'RctpDt': rctpDt,
      'RcptTm': rcptTm,
      'ClsFlg': clsFlg,
      'CldMode': cldMode,
      'InvNo': invNo,
      'Status': status,
      'Tte': tte,
      'InvDt': invDt,
      'Fkart': fkart,
      'EwayBill': ewayBill,
      'EwayDt': ewayDt,
      'EwayTm': ewayTm,
      'CanFlag': canFlag,
      'ScanStatus': scanStatus,
      'StatsDs': statsDs,
      'PType': pType,
      'PAction': pAction,
      'Oth1': oth1,
      'Oth2': oth2,
      'Oth3': oth3,
      'Oth4': oth4,
      'Oth5': oth5,
      'OthN1': othN1,
      'OthN2': othN2,
      'OthN3': othN3,
      'OthDt1': othDt1,
      'OthDt2': othDt2,
      'OthDt3': othDt3,
      'OtjDt4': otjDt4,
      'Oth6': oth6,
      'Oth7': oth7,
      'BillQty': billQty,
      'BillTte': billTte,
      'InvCnt': invCnt,
      'DlrCnt': dlrCnt,
      'PostCd': postCd,
      'PostMsg': postMsg,
      'TerrCode': terrCode,
      'TerrName': terrName,
      'ScanQty': scanQty,
      'AccGrp': accGrp,
      'Message': message,
      'RetrunCode': retrunCode,
      'TokenId': tokenId,
      'uniqueRowId': uniqueRowId,
    };
  }
}

String? _str(dynamic v) {
  if (v == null) return null;
  if (v is String) return v;
  return v.toString();
}

// To parse the overall response which contains a list of RouteTertiaryModel:
class RouteTertiaryResponse {
  final bool? success;
  final String? message;
  final List<RouteTertiaryModel>? data;

  RouteTertiaryResponse({
    this.success,
    this.message,
    this.data,
  });

  factory RouteTertiaryResponse.fromJson(Map<String, dynamic> json) {
    return RouteTertiaryResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RouteTertiaryModel.fromJson(
                Map<String, dynamic>.from(e as Map),
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}
