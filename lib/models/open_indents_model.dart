import 'dart:convert';

OpenIndentsResponse openIndentsResponseFromJson(String str) =>
    OpenIndentsResponse.fromJson(json.decode(str));

String openIndentsResponseToJson(OpenIndentsResponse data) =>
    json.encode(data.toJson());

class OpenIndentsResponse {
  final bool success;
  final String message;
  final List<OpenIndent> data;

  OpenIndentsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OpenIndentsResponse.fromJson(Map<String, dynamic> json) =>
      OpenIndentsResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        data: (json['data'] as List? ?? [])
            .map(
              (e) => OpenIndent.fromJson(
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

class OpenIndent {
  final Metadata metadata;
  bool isSelected;
  final String orderId;
  final String indStatus;
  final String srcLoc;
  final String distLoc;
  final String city;
  final String distName;
  final String srcName;
  final String category;
  final String pickDate;
  final String pickTime;
  final String skuCnt;
  final String baseWeight;
  final String baseQty;
  final String baseTte;
  final String tte;
  final String truckType;
  final String vsart;
  final String market;
  final String movement;
  final String subMovement;
  final String status;
  final String ername;
  final String oth1;
  final String oth2;
  final String oth3;
  final String oth4;
  final String oth5;
  final String matnr;
  final String maktx;
  final String line;
  final String unit;
  final String shipment;
  final String mode;
  final String spotBill;
  final String shipStatus;
  final String delOrder;
  final String delStatus;
  final String docType;
  final String transCd;
  final String trnasName;
  final String scac;
  final String utlTte;
  final String utlWeight;
  final String utlWt;
  final String spotBid;
  final String billTo;
  final String billToNm;
  final String sapCarrier;
  final String matnrTb;
  final String tbQty;
  final String matnrFl;
  final String flQty;
  final String ttType;
  final String relQty;
  final String postStatus;
  final String postMsg;
  final String errStatus;
  final String errLog;
  final String vtweg;
  final String subMove;
  final String turckNo;
  final String diverNo;
  final String bbnd;
  final String oldCode;
  final String lrNo;
  final String lrDt;
  final String pErdat;
  final String pErtype;
  final String pPickTp;
  final String pMove;
  final String pSegm;
  final String pCatg;
  final String pType;
  final String tokenId;
  final String pSrc;
  final String pAction;
  final String pTrans;
  final String ttf;
  final String respDt;
  final String respTm;
  final String respUser;
  final String rank;
  final String transitTm;
  final String bidAmount;
  final String remark;
  final String spbitId;
  final String statusCd;
  final String pickDtTnt;
  final String pickTmTnt;
  final String setType;
  final String invStatus;
  final String tisStatus;
  final String gtInDt;
  final String gtInTm;
  final String wbInDt;
  final String wbInTm;
  final String invNo;
  final String delNo;
  final String aubel;
  final String auposnr;
  final String fkdat;
  final String fkart;
  final String invVal;
  final String invTax;
  final String ewayBill;
  final String freightValue;
  final String insuranceVal;
  final String netWeight;
  final String grossweight;
  final String preShipment;
  final String preShipmentDt;
  final String shippingBillno;
  final String shippingBilldt;
  final String hsnCode;
  final String tubeMatr;
  final String flapMatnr;
  final String tMode;
  final String ewayBillDt;
  final String stoNo;
  final String stoDt;
  final String invQty;
  final String scanQty;
  final String invCnt;
  final String etaDt;
  final String etaTm;
  final String tendCont;
  final String seal;
  final String shortRec;
  final String transTmPlan;
  final String transTmActul;
  final String salesInv;
  final String ftUrl;
  final String kmCoverd;
  final String kmActual;
  final String currTrkPos;
  final String sapCarrCd;
  final String pod;
  final String enroute;
  final String mobile;
  final String ldTmDt;
  final String ldTmTm;
  final String loadCost;
  final String clr1;
  final String clr2;
  final String clr3;
  final String clr4;
  final String clr5;
  final String clr6;
  final String clr7;
  final String damage;
  final String damageRes;
  final String shortRes;
  final String misSku;
  final String sapStatus;
  final String stkQty;
  final String rcptQty;
  final String trnsStk;
  final String bayStatus;
  final String chgAuth;
  final String bayCd;
  final String bayName;
  final String reqCd;
  final String reqDesc;
  final String spbidRespDt;
  final String spbidRespTm;
  final String spbidDistance;
  final String spbidSrlno;
  final String spbidWinner;
  final String despPriotiry;
  final String vechBlack;
  final String truckBlack;
  final String colourCd;
  final String grnNo;
  final String grnDt;
  final String grnQty;
  final String uniqueRowId;

  OpenIndent({
    required this.metadata,
    this.isSelected = false,
    required this.orderId,
    required this.indStatus,
    required this.srcLoc,
    required this.distLoc,
    required this.city,
    required this.distName,
    required this.srcName,
    required this.category,
    required this.pickDate,
    required this.pickTime,
    required this.skuCnt,
    required this.baseWeight,
    required this.baseQty,
    required this.baseTte,
    required this.tte,
    required this.truckType,
    required this.vsart,
    required this.market,
    required this.movement,
    required this.subMovement,
    required this.status,
    required this.ername,
    required this.oth1,
    required this.oth2,
    required this.oth3,
    required this.oth4,
    required this.oth5,
    required this.matnr,
    required this.maktx,
    required this.line,
    required this.unit,
    required this.shipment,
    required this.mode,
    required this.spotBill,
    required this.shipStatus,
    required this.delOrder,
    required this.delStatus,
    required this.docType,
    required this.transCd,
    required this.trnasName,
    required this.scac,
    required this.utlTte,
    required this.utlWeight,
    required this.utlWt,
    required this.spotBid,
    required this.billTo,
    required this.billToNm,
    required this.sapCarrier,
    required this.matnrTb,
    required this.tbQty,
    required this.matnrFl,
    required this.flQty,
    required this.ttType,
    required this.relQty,
    required this.postStatus,
    required this.postMsg,
    required this.errStatus,
    required this.errLog,
    required this.vtweg,
    required this.subMove,
    required this.turckNo,
    required this.diverNo,
    required this.bbnd,
    required this.oldCode,
    required this.lrNo,
    required this.lrDt,
    required this.pErdat,
    required this.pErtype,
    required this.pPickTp,
    required this.pMove,
    required this.pSegm,
    required this.pCatg,
    required this.pType,
    required this.tokenId,
    required this.pSrc,
    required this.pAction,
    required this.pTrans,
    required this.ttf,
    required this.respDt,
    required this.respTm,
    required this.respUser,
    required this.rank,
    required this.transitTm,
    required this.bidAmount,
    required this.remark,
    required this.spbitId,
    required this.statusCd,
    required this.pickDtTnt,
    required this.pickTmTnt,
    required this.setType,
    required this.invStatus,
    required this.tisStatus,
    required this.gtInDt,
    required this.gtInTm,
    required this.wbInDt,
    required this.wbInTm,
    required this.invNo,
    required this.delNo,
    required this.aubel,
    required this.auposnr,
    required this.fkdat,
    required this.fkart,
    required this.invVal,
    required this.invTax,
    required this.ewayBill,
    required this.freightValue,
    required this.insuranceVal,
    required this.netWeight,
    required this.grossweight,
    required this.preShipment,
    required this.preShipmentDt,
    required this.shippingBillno,
    required this.shippingBilldt,
    required this.hsnCode,
    required this.tubeMatr,
    required this.flapMatnr,
    required this.tMode,
    required this.ewayBillDt,
    required this.stoNo,
    required this.stoDt,
    required this.invQty,
    required this.scanQty,
    required this.invCnt,
    required this.etaDt,
    required this.etaTm,
    required this.tendCont,
    required this.seal,
    required this.shortRec,
    required this.transTmPlan,
    required this.transTmActul,
    required this.salesInv,
    required this.ftUrl,
    required this.kmCoverd,
    required this.kmActual,
    required this.currTrkPos,
    required this.sapCarrCd,
    required this.pod,
    required this.enroute,
    required this.mobile,
    required this.ldTmDt,
    required this.ldTmTm,
    required this.loadCost,
    required this.clr1,
    required this.clr2,
    required this.clr3,
    required this.clr4,
    required this.clr5,
    required this.clr6,
    required this.clr7,
    required this.damage,
    required this.damageRes,
    required this.shortRes,
    required this.misSku,
    required this.sapStatus,
    required this.stkQty,
    required this.rcptQty,
    required this.trnsStk,
    required this.bayStatus,
    required this.chgAuth,
    required this.bayCd,
    required this.bayName,
    required this.reqCd,
    required this.reqDesc,
    required this.spbidRespDt,
    required this.spbidRespTm,
    required this.spbidDistance,
    required this.spbidSrlno,
    required this.spbidWinner,
    required this.despPriotiry,
    required this.vechBlack,
    required this.truckBlack,
    required this.colourCd,
    required this.grnNo,
    required this.grnDt,
    required this.grnQty,
    required this.uniqueRowId,
  });

  factory OpenIndent.fromJson(Map<String, dynamic> json) => OpenIndent(
        metadata: Metadata.fromJson(
          json['__metadata'] as Map<String, dynamic>? ?? const {},
        ),
        orderId: json['OrderId'] as String? ?? '',
        indStatus: json['IndStatus'] as String? ?? '',
        srcLoc: json['SrcLoc'] as String? ?? '',
        distLoc: json['DistLoc'] as String? ?? '',
        city: json['City'] as String? ?? '',
        distName: json['DistName'] as String? ?? '',
        srcName: json['SrcName'] as String? ?? '',
        category: json['Category'] as String? ?? '',
        pickDate: json['PickDate'] as String? ?? '',
        pickTime: json['PickTime'] as String? ?? '',
        skuCnt: json['SkuCnt'] as String? ?? '',
        baseWeight: json['BaseWeight'] as String? ?? '',
        baseQty: json['BaseQty'] as String? ?? '',
        baseTte: json['BaseTte'] as String? ?? '',
        tte: json['Tte'] as String? ?? '',
        truckType: json['TruckType'] as String? ?? '',
        vsart: json['Vsart'] as String? ?? '',
        market: json['Market'] as String? ?? '',
        movement: json['Movement'] as String? ?? '',
        subMovement: json['SubMovement'] as String? ?? '',
        status: json['Status'] as String? ?? '',
        ername: json['Ername'] as String? ?? '',
        oth1: json['Oth1'] as String? ?? '',
        oth2: json['Oth2'] as String? ?? '',
        oth3: json['Oth3'] as String? ?? '',
        oth4: json['Oth4'] as String? ?? '',
        oth5: json['Oth5'] as String? ?? '',
        matnr: json['Matnr'] as String? ?? '',
        maktx: json['Maktx'] as String? ?? '',
        line: json['Line'] as String? ?? '',
        unit: json['Unit'] as String? ?? '',
        shipment: json['Shipment'] as String? ?? '',
        mode: json['Mode'] as String? ?? '',
        spotBill: json['SpotBill'] as String? ?? '',
        shipStatus: json['ShipStatus'] as String? ?? '',
        delOrder: json['DelOrder'] as String? ?? '',
        delStatus: json['DelStatus'] as String? ?? '',
        docType: json['DocType'] as String? ?? '',
        transCd: json['TransCd'] as String? ?? '',
        trnasName: json['TrnasName'] as String? ?? '',
        scac: json['Scac'] as String? ?? '',
        utlTte: json['UtlTte'] as String? ?? '',
        utlWeight: json['UtlWeight'] as String? ?? '',
        utlWt: json['UtlWt'] as String? ?? '',
        spotBid: json['SpotBid'] as String? ?? '',
        billTo: json['BillTo'] as String? ?? '',
        billToNm: json['BillToNm'] as String? ?? '',
        sapCarrier: json['SapCarrier'] as String? ?? '',
        matnrTb: json['MatnrTb'] as String? ?? '',
        tbQty: json['TbQty'] as String? ?? '',
        matnrFl: json['MatnrFl'] as String? ?? '',
        flQty: json['FlQty'] as String? ?? '',
        ttType: json['TtType'] as String? ?? '',
        relQty: json['RelQty'] as String? ?? '',
        postStatus: json['PostStatus'] as String? ?? '',
        postMsg: json['PostMsg'] as String? ?? '',
        errStatus: json['ErrStatus'] as String? ?? '',
        errLog: json['ErrLog'] as String? ?? '',
        vtweg: json['Vtweg'] as String? ?? '',
        subMove: json['SubMove'] as String? ?? '',
        turckNo: json['TurckNo'] as String? ?? '',
        diverNo: json['DiverNo'] as String? ?? '',
        bbnd: json['Bbnd'] as String? ?? '',
        oldCode: json['OldCode'] as String? ?? '',
        lrNo: json['LrNo'] as String? ?? '',
        lrDt: json['LrDt'] as String? ?? '',
        pErdat: json['PErdat'] as String? ?? '',
        pErtype: json['PErtype'] as String? ?? '',
        pPickTp: json['PPickTp'] as String? ?? '',
        pMove: json['PMove'] as String? ?? '',
        pSegm: json['PSegm'] as String? ?? '',
        pCatg: json['PCatg'] as String? ?? '',
        pType: json['PType'] as String? ?? '',
        tokenId: json['TokenId'] as String? ?? '',
        pSrc: json['PSrc'] as String? ?? '',
        pAction: json['PAction'] as String? ?? '',
        pTrans: json['PTrans'] as String? ?? '',
        ttf: json['Ttf'] as String? ?? '',
        respDt: json['RespDt'] as String? ?? '',
        respTm: json['RespTm'] as String? ?? '',
        respUser: json['RespUser'] as String? ?? '',
        rank: json['Rank'] as String? ?? '',
        transitTm: json['TransitTm'] as String? ?? '',
        bidAmount: json['BidAmount'] as String? ?? '',
        remark: json['Remark'] as String? ?? '',
        spbitId: json['SpbitId'] as String? ?? '',
        statusCd: json['StatusCd'] as String? ?? '',
        pickDtTnt: json['PickDtTnt'] as String? ?? '',
        pickTmTnt: json['PickTmTnt'] as String? ?? '',
        setType: json['SetType'] as String? ?? '',
        invStatus: json['InvStatus'] as String? ?? '',
        tisStatus: json['TisStatus'] as String? ?? '',
        gtInDt: json['GtInDt'] as String? ?? '',
        gtInTm: json['GtInTm'] as String? ?? '',
        wbInDt: json['WbInDt'] as String? ?? '',
        wbInTm: json['WbInTm'] as String? ?? '',
        invNo: json['InvNo'] as String? ?? '',
        delNo: json['DelNo'] as String? ?? '',
        aubel: json['Aubel'] as String? ?? '',
        auposnr: json['Auposnr'] as String? ?? '',
        fkdat: json['Fkdat'] as String? ?? '',
        fkart: json['Fkart'] as String? ?? '',
        invVal: json['InvVal'] as String? ?? '',
        invTax: json['InvTax'] as String? ?? '',
        ewayBill: json['EwayBill'] as String? ?? '',
        freightValue: json['FreightValue'] as String? ?? '',
        insuranceVal: json['InsuranceVal'] as String? ?? '',
        netWeight: json['NetWeight'] as String? ?? '',
        grossweight: json['Grossweight'] as String? ?? '',
        preShipment: json['PreShipment'] as String? ?? '',
        preShipmentDt: json['PreShipmentDt'] as String? ?? '',
        shippingBillno: json['ShippingBillno'] as String? ?? '',
        shippingBilldt: json['ShippingBilldt'] as String? ?? '',
        hsnCode: json['HsnCode'] as String? ?? '',
        tubeMatr: json['TubeMatr'] as String? ?? '',
        flapMatnr: json['FlapMatnr'] as String? ?? '',
        tMode: json['TMode'] as String? ?? '',
        ewayBillDt: json['EwayBillDt'] as String? ?? '',
        stoNo: json['StoNo'] as String? ?? '',
        stoDt: json['StoDt'] as String? ?? '',
        invQty: json['InvQty'] as String? ?? '',
        scanQty: json['ScanQty'] as String? ?? '',
        invCnt: json['InvCnt'] as String? ?? '',
        etaDt: json['EtaDt'] as String? ?? '',
        etaTm: json['EtaTm'] as String? ?? '',
        tendCont: json['TendCont'] as String? ?? '',
        seal: json['Seal'] as String? ?? '',
        shortRec: json['ShortRec'] as String? ?? '',
        transTmPlan: json['TransTmPlan'] as String? ?? '',
        transTmActul: json['TransTmActul'] as String? ?? '',
        salesInv: json['SalesInv'] as String? ?? '',
        ftUrl: json['FtUrl'] as String? ?? '',
        kmCoverd: json['KmCoverd'] as String? ?? '',
        kmActual: json['KmActual'] as String? ?? '',
        currTrkPos: json['CurrTrkPos'] as String? ?? '',
        sapCarrCd: json['SapCarrCd'] as String? ?? '',
        pod: json['Pod'] as String? ?? '',
        enroute: json['Enroute'] as String? ?? '',
        mobile: json['Mobile'] as String? ?? '',
        ldTmDt: json['LdTmDt'] as String? ?? '',
        ldTmTm: json['LdTmTm'] as String? ?? '',
        loadCost: json['LoadCost'] as String? ?? '',
        clr1: json['Clr1'] as String? ?? '',
        clr2: json['Clr2'] as String? ?? '',
        clr3: json['Clr3'] as String? ?? '',
        clr4: json['Clr4'] as String? ?? '',
        clr5: json['Clr5'] as String? ?? '',
        clr6: json['Clr6'] as String? ?? '',
        clr7: json['Clr7'] as String? ?? '',
        damage: json['Damage'] as String? ?? '',
        damageRes: json['DamageRes'] as String? ?? '',
        shortRes: json['ShortRes'] as String? ?? '',
        misSku: json['MisSku'] as String? ?? '',
        sapStatus: json['SapStatus'] as String? ?? '',
        stkQty: json['StkQty'] as String? ?? '',
        rcptQty: json['RcptQty'] as String? ?? '',
        trnsStk: json['TrnsStk'] as String? ?? '',
        bayStatus: json['BayStatus'] as String? ?? '',
        chgAuth: json['ChgAuth'] as String? ?? '',
        bayCd: json['BayCd'] as String? ?? '',
        bayName: json['BayName'] as String? ?? '',
        reqCd: json['ReqCd'] as String? ?? '',
        reqDesc: json['ReqDesc'] as String? ?? '',
        spbidRespDt: json['SpbidRespDt'] as String? ?? '',
        spbidRespTm: json['SpbidRespTm'] as String? ?? '',
        spbidDistance: json['SpbidDistance'] as String? ?? '',
        spbidSrlno: json['SpbidSrlno'] as String? ?? '',
        spbidWinner: json['SpbidWinner'] as String? ?? '',
        despPriotiry: json['DespPriotiry'] as String? ?? '',
        vechBlack: json['VechBlack'] as String? ?? '',
        truckBlack: json['TruckBlack'] as String? ?? '',
        colourCd: json['ColourCd'] as String? ?? '',
        grnNo: json['GrnNo'] as String? ?? '',
        grnDt: json['GrnDt'] as String? ?? '',
        grnQty: json['GrnQty'] as String? ?? '',
        uniqueRowId: json['uniqueRowId'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        '__metadata': metadata.toJson(),
        'OrderId': orderId,
        'IndStatus': indStatus,
        'SrcLoc': srcLoc,
        'DistLoc': distLoc,
        'City': city,
        'DistName': distName,
        'SrcName': srcName,
        'Category': category,
        'PickDate': pickDate,
        'PickTime': pickTime,
        'SkuCnt': skuCnt,
        'BaseWeight': baseWeight,
        'BaseQty': baseQty,
        'BaseTte': baseTte,
        'Tte': tte,
        'TruckType': truckType,
        'Vsart': vsart,
        'Market': market,
        'Movement': movement,
        'SubMovement': subMovement,
        'Status': status,
        'Ername': ername,
        'Oth1': oth1,
        'Oth2': oth2,
        'Oth3': oth3,
        'Oth4': oth4,
        'Oth5': oth5,
        'Matnr': matnr,
        'Maktx': maktx,
        'Line': line,
        'Unit': unit,
        'Shipment': shipment,
        'Mode': mode,
        'SpotBill': spotBill,
        'ShipStatus': shipStatus,
        'DelOrder': delOrder,
        'DelStatus': delStatus,
        'DocType': docType,
        'TransCd': transCd,
        'TrnasName': trnasName,
        'Scac': scac,
        'UtlTte': utlTte,
        'UtlWeight': utlWeight,
        'UtlWt': utlWt,
        'SpotBid': spotBid,
        'BillTo': billTo,
        'BillToNm': billToNm,
        'SapCarrier': sapCarrier,
        'MatnrTb': matnrTb,
        'TbQty': tbQty,
        'MatnrFl': matnrFl,
        'FlQty': flQty,
        'TtType': ttType,
        'RelQty': relQty,
        'PostStatus': postStatus,
        'PostMsg': postMsg,
        'ErrStatus': errStatus,
        'ErrLog': errLog,
        'Vtweg': vtweg,
        'SubMove': subMove,
        'TurckNo': turckNo,
        'DiverNo': diverNo,
        'Bbnd': bbnd,
        'OldCode': oldCode,
        'LrNo': lrNo,
        'LrDt': lrDt,
        'PErdat': pErdat,
        'PErtype': pErtype,
        'PPickTp': pPickTp,
        'PMove': pMove,
        'PSegm': pSegm,
        'PCatg': pCatg,
        'PType': pType,
        'TokenId': tokenId,
        'PSrc': pSrc,
        'PAction': pAction,
        'PTrans': pTrans,
        'Ttf': ttf,
        'RespDt': respDt,
        'RespTm': respTm,
        'RespUser': respUser,
        'Rank': rank,
        'TransitTm': transitTm,
        'BidAmount': bidAmount,
        'Remark': remark,
        'SpbitId': spbitId,
        'StatusCd': statusCd,
        'PickDtTnt': pickDtTnt,
        'PickTmTnt': pickTmTnt,
        'SetType': setType,
        'InvStatus': invStatus,
        'TisStatus': tisStatus,
        'GtInDt': gtInDt,
        'GtInTm': gtInTm,
        'WbInDt': wbInDt,
        'WbInTm': wbInTm,
        'InvNo': invNo,
        'DelNo': delNo,
        'Aubel': aubel,
        'Auposnr': auposnr,
        'Fkdat': fkdat,
        'Fkart': fkart,
        'InvVal': invVal,
        'InvTax': invTax,
        'EwayBill': ewayBill,
        'FreightValue': freightValue,
        'InsuranceVal': insuranceVal,
        'NetWeight': netWeight,
        'Grossweight': grossweight,
        'PreShipment': preShipment,
        'PreShipmentDt': preShipmentDt,
        'ShippingBillno': shippingBillno,
        'ShippingBilldt': shippingBilldt,
        'HsnCode': hsnCode,
        'TubeMatr': tubeMatr,
        'FlapMatnr': flapMatnr,
        'TMode': tMode,
        'EwayBillDt': ewayBillDt,
        'StoNo': stoNo,
        'StoDt': stoDt,
        'InvQty': invQty,
        'ScanQty': scanQty,
        'InvCnt': invCnt,
        'EtaDt': etaDt,
        'EtaTm': etaTm,
        'TendCont': tendCont,
        'Seal': seal,
        'ShortRec': shortRec,
        'TransTmPlan': transTmPlan,
        'TransTmActul': transTmActul,
        'SalesInv': salesInv,
        'FtUrl': ftUrl,
        'KmCoverd': kmCoverd,
        'KmActual': kmActual,
        'CurrTrkPos': currTrkPos,
        'SapCarrCd': sapCarrCd,
        'Pod': pod,
        'Enroute': enroute,
        'Mobile': mobile,
        'LdTmDt': ldTmDt,
        'LdTmTm': ldTmTm,
        'LoadCost': loadCost,
        'Clr1': clr1,
        'Clr2': clr2,
        'Clr3': clr3,
        'Clr4': clr4,
        'Clr5': clr5,
        'Clr6': clr6,
        'Clr7': clr7,
        'Damage': damage,
        'DamageRes': damageRes,
        'ShortRes': shortRes,
        'MisSku': misSku,
        'SapStatus': sapStatus,
        'StkQty': stkQty,
        'RcptQty': rcptQty,
        'TrnsStk': trnsStk,
        'BayStatus': bayStatus,
        'ChgAuth': chgAuth,
        'BayCd': bayCd,
        'BayName': bayName,
        'ReqCd': reqCd,
        'ReqDesc': reqDesc,
        'SpbidRespDt': spbidRespDt,
        'SpbidRespTm': spbidRespTm,
        'SpbidDistance': spbidDistance,
        'SpbidSrlno': spbidSrlno,
        'SpbidWinner': spbidWinner,
        'DespPriotiry': despPriotiry,
        'VechBlack': vechBlack,
        'TruckBlack': truckBlack,
        'ColourCd': colourCd,
        'GrnNo': grnNo,
        'GrnDt': grnDt,
        'GrnQty': grnQty,
        'uniqueRowId': uniqueRowId,
      };
}

class Metadata {
  final String id;
  final String uri;
  final String type;

  const Metadata({
    required this.id,
    required this.uri,
    required this.type,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json['id'] as String? ?? '',
        uri: json['uri'] as String? ?? '',
        type: json['type'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uri': uri,
        'type': type,
      };
}
