class InvoiceDetailResponse {
  final bool success;
  final String message;
  final List<InvoiceDetailModel> data;

  InvoiceDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory InvoiceDetailResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => InvoiceDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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

class InvoiceDetailMetadata {
  final String id;
  final String uri;
  final String type;

  InvoiceDetailMetadata({
    required this.id,
    required this.uri,
    required this.type,
  });

  factory InvoiceDetailMetadata.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailMetadata(
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

class InvoiceDetailModel {
  final InvoiceDetailMetadata metadata;
  final String postStatus;
  final String dayCd;
  final String pickDate;
  final String indStatus;
  final String serviceCd;
  final String dayNm;
  final String bbnd;
  final String routeId;
  final String matnr;
  final String autoFlg;
  final String maktx;
  final String serName;
  final String dlayFlg;
  final String lat;
  final String mobNo;
  final String longVal;
  final String tripNo;
  final String tripId;
  final String ertype;
  final String yMail;
  final String distLoc;
  final String lifnr;
  final String pickType;
  final String routeCd;
  final String routeName;
  final String beatCutTm;
  final String pSegm;
  final String beatOutTm;
  final String routeType;
  final String beatCd;
  final String locCd;
  final String noBeatWk;
  final String beatFreq;
  final String minTte;
  final String maxTtr;
  final String dailyBeatFreq;
  final String beatDistance;
  final String minVechSize;
  final String remark;
  final String erdat;
  final String ername;
  final String locName;
  final String kunnr;
  final String custName;
  final String rtDate;
  final String rtTime;
  final String truckNo;
  final String drivLicNo;
  final String make;
  final String makeTte;
  final String actTte;
  final String outDt;
  final String outTm;
  final String outBy;
  final String rcptFlg;
  final String rctpDt;
  final String rcptTm;
  final String clsFlg;
  final String cldMode;
  final String invNo;
  final String status;
  final String tte;
  final String invDt;
  final String fkart;
  final String ewayBill;
  final String ewayDt;
  final String ewayTm;
  final String canFlag;
  final String scanStatus;
  final String statsDs;
  final String pType;
  final String pAction;
  final String oth1;
  final String oth2;
  final String oth3;
  final String oth4;
  final String oth5;
  final String othN1;
  final String othN2;
  final String othN3;
  final String othDt1;
  final String othDt2;
  final String othDt3;
  final String otjDt4;
  final String oth6;
  final String oth7;
  final String billQty;
  final String billTte;
  final String invCnt;
  final String dlrCnt;
  final String postCd;
  final String postMsg;
  final String terrCode;
  final String terrName;
  final String scanQty;
  final String accGrp;
  final String message;
  final String retrunCode;
  final String tokenId;
  final String uniqueRowId;

  InvoiceDetailModel({
    required this.metadata,
    required this.postStatus,
    required this.dayCd,
    required this.pickDate,
    required this.indStatus,
    required this.serviceCd,
    required this.dayNm,
    required this.bbnd,
    required this.routeId,
    required this.matnr,
    required this.autoFlg,
    required this.maktx,
    required this.serName,
    required this.dlayFlg,
    required this.lat,
    required this.mobNo,
    required this.longVal,
    required this.tripNo,
    required this.tripId,
    required this.ertype,
    required this.yMail,
    required this.distLoc,
    required this.lifnr,
    required this.pickType,
    required this.routeCd,
    required this.routeName,
    required this.beatCutTm,
    required this.pSegm,
    required this.beatOutTm,
    required this.routeType,
    required this.beatCd,
    required this.locCd,
    required this.noBeatWk,
    required this.beatFreq,
    required this.minTte,
    required this.maxTtr,
    required this.dailyBeatFreq,
    required this.beatDistance,
    required this.minVechSize,
    required this.remark,
    required this.erdat,
    required this.ername,
    required this.locName,
    required this.kunnr,
    required this.custName,
    required this.rtDate,
    required this.rtTime,
    required this.truckNo,
    required this.drivLicNo,
    required this.make,
    required this.makeTte,
    required this.actTte,
    required this.outDt,
    required this.outTm,
    required this.outBy,
    required this.rcptFlg,
    required this.rctpDt,
    required this.rcptTm,
    required this.clsFlg,
    required this.cldMode,
    required this.invNo,
    required this.status,
    required this.tte,
    required this.invDt,
    required this.fkart,
    required this.ewayBill,
    required this.ewayDt,
    required this.ewayTm,
    required this.canFlag,
    required this.scanStatus,
    required this.statsDs,
    required this.pType,
    required this.pAction,
    required this.oth1,
    required this.oth2,
    required this.oth3,
    required this.oth4,
    required this.oth5,
    required this.othN1,
    required this.othN2,
    required this.othN3,
    required this.othDt1,
    required this.othDt2,
    required this.othDt3,
    required this.otjDt4,
    required this.oth6,
    required this.oth7,
    required this.billQty,
    required this.billTte,
    required this.invCnt,
    required this.dlrCnt,
    required this.postCd,
    required this.postMsg,
    required this.terrCode,
    required this.terrName,
    required this.scanQty,
    required this.accGrp,
    required this.message,
    required this.retrunCode,
    required this.tokenId,
    required this.uniqueRowId,
  });

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailModel(
      metadata: InvoiceDetailMetadata.fromJson(
          json['__metadata'] ?? <String, dynamic>{}),
      postStatus: json['PostStatus'] ?? '',
      dayCd: json['DayCd'] ?? '',
      pickDate: json['PickDate'] ?? '',
      indStatus: json['IndStatus'] ?? '',
      serviceCd: json['ServiceCd'] ?? '',
      dayNm: json['DayNm'] ?? '',
      bbnd: json['Bbnd'] ?? '',
      routeId: json['RouteId'] ?? '',
      matnr: json['Matnr'] ?? '',
      autoFlg: json['AutoFlg'] ?? '',
      maktx: json['Maktx'] ?? '',
      serName: json['SerName'] ?? '',
      dlayFlg: json['DlayFlg'] ?? '',
      lat: json['Lat'] ?? '',
      mobNo: json['MobNo'] ?? '',
      longVal: json['Long'] ?? '',
      tripNo: json['TripNo'] ?? '',
      tripId: json['TripId'] ?? '',
      ertype: json['Ertype'] ?? '',
      yMail: json['YMail'] ?? '',
      distLoc: json['DistLoc'] ?? '',
      lifnr: json['Lifnr'] ?? '',
      pickType: json['PickType'] ?? '',
      routeCd: json['RouteCd'] ?? '',
      routeName: json['RouteName'] ?? '',
      beatCutTm: json['BeatCutTm'] ?? '',
      pSegm: json['PSegm'] ?? '',
      beatOutTm: json['BeatOutTm'] ?? '',
      routeType: json['RouteType'] ?? '',
      beatCd: json['BeatCd'] ?? '',
      locCd: json['LocCd'] ?? '',
      noBeatWk: json['NoBeatWk'] ?? '',
      beatFreq: json['BeatFreq'] ?? '',
      minTte: json['MinTte'] ?? '',
      maxTtr: json['MaxTtr'] ?? '',
      dailyBeatFreq: json['DailyBeatFreq'] ?? '',
      beatDistance: json['BeatDistance'] ?? '',
      minVechSize: json['MinVechSize'] ?? '',
      remark: json['Remark'] ?? '',
      erdat: json['Erdat'] ?? '',
      ername: json['Ername'] ?? '',
      locName: json['LocName'] ?? '',
      kunnr: json['Kunnr'] ?? '',
      custName: json['CustName'] ?? '',
      rtDate: json['RtDate'] ?? '',
      rtTime: json['RtTime'] ?? '',
      truckNo: json['TruckNo'] ?? '',
      drivLicNo: json['DrivLicNo'] ?? '',
      make: json['Make'] ?? '',
      makeTte: json['MakeTte'] ?? '',
      actTte: json['ActTte'] ?? '',
      outDt: json['OutDt'] ?? '',
      outTm: json['OutTm'] ?? '',
      outBy: json['OutBy'] ?? '',
      rcptFlg: json['RcptFlg'] ?? '',
      rctpDt: json['RctpDt'] ?? '',
      rcptTm: json['RcptTm'] ?? '',
      clsFlg: json['ClsFlg'] ?? '',
      cldMode: json['CldMode'] ?? '',
      invNo: json['InvNo'] ?? '',
      status: json['Status'] ?? '',
      tte: json['Tte'] ?? '',
      invDt: json['InvDt'] ?? '',
      fkart: json['Fkart'] ?? '',
      ewayBill: json['EwayBill'] ?? '',
      ewayDt: json['EwayDt'] ?? '',
      ewayTm: json['EwayTm'] ?? '',
      canFlag: json['CanFlag'] ?? '',
      scanStatus: json['ScanStatus'] ?? '',
      statsDs: json['StatsDs'] ?? '',
      pType: json['PType'] ?? '',
      pAction: json['PAction'] ?? '',
      oth1: json['Oth1'] ?? '',
      oth2: json['Oth2'] ?? '',
      oth3: json['Oth3'] ?? '',
      oth4: json['Oth4'] ?? '',
      oth5: json['Oth5'] ?? '',
      othN1: json['OthN1'] ?? '',
      othN2: json['OthN2'] ?? '',
      othN3: json['OthN3'] ?? '',
      othDt1: json['OthDt1'] ?? '',
      othDt2: json['OthDt2'] ?? '',
      othDt3: json['OthDt3'] ?? '',
      otjDt4: json['OtjDt4'] ?? '',
      oth6: json['Oth6'] ?? '',
      oth7: json['Oth7'] ?? '',
      billQty: json['BillQty'] ?? '',
      billTte: json['BillTte'] ?? '',
      invCnt: json['InvCnt'] ?? '',
      dlrCnt: json['DlrCnt'] ?? '',
      postCd: json['PostCd'] ?? '',
      postMsg: json['PostMsg'] ?? '',
      terrCode: json['TerrCode'] ?? '',
      terrName: json['TerrName'] ?? '',
      scanQty: json['ScanQty'] ?? '',
      accGrp: json['AccGrp'] ?? '',
      message: json['Message'] ?? '',
      retrunCode: json['RetrunCode'] ?? '',
      tokenId: json['TokenId'] ?? '',
      uniqueRowId: json['uniqueRowId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '__metadata': metadata.toJson(),
      'PostStatus': postStatus,
      'DayCd': dayCd,
      'PickDate': pickDate,
      'IndStatus': indStatus,
      'ServiceCd': serviceCd,
      'DayNm': dayNm,
      'Bbnd': bbnd,
      'RouteId': routeId,
      'Matnr': matnr,
      'AutoFlg': autoFlg,
      'Maktx': maktx,
      'SerName': serName,
      'DlayFlg': dlayFlg,
      'Lat': lat,
      'MobNo': mobNo,
      'Long': longVal,
      'TripNo': tripNo,
      'TripId': tripId,
      'Ertype': ertype,
      'YMail': yMail,
      'DistLoc': distLoc,
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
