class ActiveTripsResponse {
  final bool success;
  final String message;
  final List<ActiveTripModel> data;

  ActiveTripsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ActiveTripsResponse.fromJson(Map<String, dynamic> json) {
    return ActiveTripsResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      data: (json['data'] as List)
          .map((e) => ActiveTripModel.fromJson(e))
          .toList(),
    );
  }
}

class ActiveTripModel {
  final Metadata metadata;
  final String dayCd;
  final String pickDate;
  final String dayNm;
  final String serviceCd;
  final String matnr;
  final String routeId;
  final String maktx;
  final String serName;
  final String mobNo;
  final String lat;
  final String tripNo;
  final String longVal;
  final String tripId;
  final String ertype;
  final String distLoc;
  final String yMail;
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

  ActiveTripModel({
    required this.metadata,
    required this.dayCd,
    required this.pickDate,
    required this.dayNm,
    required this.serviceCd,
    required this.matnr,
    required this.routeId,
    required this.maktx,
    required this.serName,
    required this.mobNo,
    required this.lat,
    required this.tripNo,
    required this.longVal,
    required this.tripId,
    required this.ertype,
    required this.distLoc,
    required this.yMail,
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

  factory ActiveTripModel.fromJson(Map<String, dynamic> json) {
    return ActiveTripModel(
      metadata: Metadata.fromJson(json['__metadata'] as Map<String, dynamic>),
      dayCd: json['DayCd'] as String? ?? "",
      pickDate: json['PickDate'] as String? ?? "",
      dayNm: json['DayNm'] as String? ?? "",
      serviceCd: json['ServiceCd'] as String? ?? "",
      matnr: json['Matnr'] as String? ?? "",
      routeId: json['RouteId'] as String? ?? "",
      maktx: json['Maktx'] as String? ?? "",
      serName: json['SerName'] as String? ?? "",
      mobNo: json['MobNo'] as String? ?? "",
      lat: json['Lat'] as String? ?? "",
      tripNo: json['TripNo'] as String? ?? "",
      longVal: json['Long'] as String? ?? "",
      tripId: json['TripId'] as String? ?? "",
      ertype: json['Ertype'] as String? ?? "",
      distLoc: json['DistLoc'] as String? ?? "",
      yMail: json['YMail'] as String? ?? "",
      lifnr: json['Lifnr'] as String? ?? "",
      pickType: json['PickType'] as String? ?? "",
      routeCd: json['RouteCd'] as String? ?? "",
      routeName: json['RouteName'] as String? ?? "",
      beatCutTm: json['BeatCutTm'] as String? ?? "",
      pSegm: json['PSegm'] as String? ?? "",
      beatOutTm: json['BeatOutTm'] as String? ?? "",
      routeType: json['RouteType'] as String? ?? "",
      beatCd: json['BeatCd'] as String? ?? "",
      locCd: json['LocCd'] as String? ?? "",
      noBeatWk: json['NoBeatWk'] as String? ?? "",
      beatFreq: json['BeatFreq'] as String? ?? "",
      minTte: json['MinTte'] as String? ?? "",
      maxTtr: json['MaxTtr'] as String? ?? "",
      dailyBeatFreq: json['DailyBeatFreq'] as String? ?? "",
      beatDistance: json['BeatDistance'] as String? ?? "",
      minVechSize: json['MinVechSize'] as String? ?? "",
      remark: json['Remark'] as String? ?? "",
      erdat: json['Erdat'] as String? ?? "",
      ername: json['Ername'] as String? ?? "",
      locName: json['LocName'] as String? ?? "",
      kunnr: json['Kunnr'] as String? ?? "",
      custName: json['CustName'] as String? ?? "",
      rtDate: json['RtDate'] as String? ?? "",
      rtTime: json['RtTime'] as String? ?? "",
      truckNo: json['TruckNo'] as String? ?? "",
      drivLicNo: json['DrivLicNo'] as String? ?? "",
      make: json['Make'] as String? ?? "",
      makeTte: json['MakeTte'] as String? ?? "",
      actTte: json['ActTte'] as String? ?? "",
      outDt: json['OutDt'] as String? ?? "",
      outTm: json['OutTm'] as String? ?? "",
      outBy: json['OutBy'] as String? ?? "",
      rcptFlg: json['RcptFlg'] as String? ?? "",
      rctpDt: json['RctpDt'] as String? ?? "",
      rcptTm: json['RcptTm'] as String? ?? "",
      clsFlg: json['ClsFlg'] as String? ?? "",
      cldMode: json['CldMode'] as String? ?? "",
      invNo: json['InvNo'] as String? ?? "",
      status: json['Status'] as String? ?? "",
      tte: json['Tte'] as String? ?? "",
      invDt: json['InvDt'] as String? ?? "",
      fkart: json['Fkart'] as String? ?? "",
      ewayBill: json['EwayBill'] as String? ?? "",
      ewayDt: json['EwayDt'] as String? ?? "",
      ewayTm: json['EwayTm'] as String? ?? "",
      canFlag: json['CanFlag'] as String? ?? "",
      scanStatus: json['ScanStatus'] as String? ?? "",
      statsDs: json['StatsDs'] as String? ?? "",
      pType: json['PType'] as String? ?? "",
      pAction: json['PAction'] as String? ?? "",
      oth1: json['Oth1'] as String? ?? "",
      oth2: json['Oth2'] as String? ?? "",
      oth3: json['Oth3'] as String? ?? "",
      oth4: json['Oth4'] as String? ?? "",
      oth5: json['Oth5'] as String? ?? "",
      othN1: json['OthN1'] as String? ?? "",
      othN2: json['OthN2'] as String? ?? "",
      othN3: json['OthN3'] as String? ?? "",
      othDt1: json['OthDt1'] as String? ?? "",
      othDt2: json['OthDt2'] as String? ?? "",
      othDt3: json['OthDt3'] as String? ?? "",
      otjDt4: json['OtjDt4'] as String? ?? "",
      oth6: json['Oth6'] as String? ?? "",
      oth7: json['Oth7'] as String? ?? "",
      billQty: json['BillQty'] as String? ?? "",
      billTte: json['BillTte'] as String? ?? "",
      invCnt: json['InvCnt'] as String? ?? "",
      dlrCnt: json['DlrCnt'] as String? ?? "",
      postCd: json['PostCd'] as String? ?? "",
      postMsg: json['PostMsg'] as String? ?? "",
      terrCode: json['TerrCode'] as String? ?? "",
      terrName: json['TerrName'] as String? ?? "",
      scanQty: json['ScanQty'] as String? ?? "",
      accGrp: json['AccGrp'] as String? ?? "",
      message: json['Message'] as String? ?? "",
      retrunCode: json['RetrunCode'] as String? ?? "",
      tokenId: json['TokenId'] as String? ?? "",
      uniqueRowId: json['uniqueRowId'] as String? ?? "",
    );
  }
}

/// Minimal metadata class based on the context. Extend as necessary.
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
      id: json['id'] as String? ?? "",
      uri: json['uri'] as String? ?? "",
      type: json['type'] as String? ?? "",
    );
  }
}