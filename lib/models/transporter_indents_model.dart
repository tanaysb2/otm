import 'dart:convert';

TransporterIndentsResponse transporterIndentsResponseFromJson(String str) =>
    TransporterIndentsResponse.fromJson(json.decode(str));

String transporterIndentsResponseToJson(TransporterIndentsResponse data) =>
    json.encode(data.toJson());

class TransporterIndentsResponse {
  final bool success;
  final String message;
  final List<TransporterIndent> data;

  TransporterIndentsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransporterIndentsResponse.fromJson(Map<String, dynamic> json) =>
      TransporterIndentsResponse(
        success: json['success'] == null ? false : json['success'],
        message: json['message'] == null ? '' : json['message'],
        data: (json['data'] as List? ?? [])
            .map(
              (e) => TransporterIndent.fromJson(
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

class TransporterIndent {
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

  TransporterIndent({
    required this.metadata,
    this.isSelected = false,
    this.orderId = '',
    this.indStatus = '',
    this.srcLoc = '',
    this.distLoc = '',
    this.city = '',
    this.distName = '',
    this.srcName = '',
    this.category = '',
    this.pickDate = '',
    this.pickTime = '',
    this.skuCnt = '',
    this.baseWeight = '',
    this.baseQty = '',
    this.baseTte = '',
    this.tte = '',
    this.truckType = '',
    this.vsart = '',
    this.market = '',
    this.movement = '',
    this.subMovement = '',
    this.status = '',
    this.ername = '',
    this.oth1 = '',
    this.oth2 = '',
    this.oth3 = '',
    this.oth4 = '',
    this.oth5 = '',
    this.matnr = '',
    this.maktx = '',
    this.line = '',
    this.unit = '',
    this.shipment = '',
    this.mode = '',
    this.spotBill = '',
    this.shipStatus = '',
    this.delOrder = '',
    this.delStatus = '',
    this.docType = '',
    this.transCd = '',
    this.trnasName = '',
    this.scac = '',
    this.utlTte = '',
    this.utlWeight = '',
    this.utlWt = '',
    this.spotBid = '',
    this.billTo = '',
    this.billToNm = '',
    this.sapCarrier = '',
    this.matnrTb = '',
    this.tbQty = '',
    this.matnrFl = '',
    this.flQty = '',
    this.ttType = '',
    this.relQty = '',
    this.postStatus = '',
    this.postMsg = '',
    this.errStatus = '',
    this.errLog = '',
    this.vtweg = '',
    this.subMove = '',
    this.turckNo = '',
    this.diverNo = '',
    this.bbnd = '',
    this.oldCode = '',
    this.lrNo = '',
    this.lrDt = '',
    this.pErdat = '',
    this.pErtype = '',
    this.pPickTp = '',
    this.pMove = '',
    this.pSegm = '',
    this.pCatg = '',
    this.pType = '',
    this.tokenId = '',
    this.pSrc = '',
    this.pAction = '',
    this.pTrans = '',
    this.ttf = '',
    this.respDt = '',
    this.respTm = '',
    this.respUser = '',
    this.rank = '',
    this.transitTm = '',
    this.bidAmount = '',
    this.remark = '',
    this.spbitId = '',
    this.statusCd = '',
    this.pickDtTnt = '',
    this.pickTmTnt = '',
    this.setType = '',
    this.invStatus = '',
    this.tisStatus = '',
    this.gtInDt = '',
    this.gtInTm = '',
    this.wbInDt = '',
    this.wbInTm = '',
    this.invNo = '',
    this.delNo = '',
    this.aubel = '',
    this.auposnr = '',
    this.fkdat = '',
    this.fkart = '',
    this.invVal = '',
    this.invTax = '',
    this.ewayBill = '',
    this.freightValue = '',
    this.insuranceVal = '',
    this.netWeight = '',
    this.grossweight = '',
    this.preShipment = '',
    this.preShipmentDt = '',
    this.shippingBillno = '',
    this.shippingBilldt = '',
    this.hsnCode = '',
    this.tubeMatr = '',
    this.flapMatnr = '',
    this.tMode = '',
    this.ewayBillDt = '',
    this.stoNo = '',
    this.stoDt = '',
    this.invQty = '',
    this.scanQty = '',
    this.invCnt = '',
    this.etaDt = '',
    this.etaTm = '',
    this.tendCont = '',
    this.seal = '',
    this.shortRec = '',
    this.transTmPlan = '',
    this.transTmActul = '',
    this.salesInv = '',
    this.ftUrl = '',
    this.kmCoverd = '',
    this.kmActual = '',
    this.currTrkPos = '',
    this.sapCarrCd = '',
    this.pod = '',
    this.enroute = '',
    this.mobile = '',
    this.ldTmDt = '',
    this.ldTmTm = '',
    this.loadCost = '',
    this.clr1 = '',
    this.clr2 = '',
    this.clr3 = '',
    this.clr4 = '',
    this.clr5 = '',
    this.clr6 = '',
    this.clr7 = '',
    this.damage = '',
    this.damageRes = '',
    this.shortRes = '',
    this.misSku = '',
    this.sapStatus = '',
    this.stkQty = '',
    this.rcptQty = '',
    this.trnsStk = '',
    this.bayStatus = '',
    this.chgAuth = '',
    this.bayCd = '',
    this.bayName = '',
    this.reqCd = '',
    this.reqDesc = '',
    this.spbidRespDt = '',
    this.spbidRespTm = '',
    this.spbidDistance = '',
    this.spbidSrlno = '',
    this.spbidWinner = '',
    this.despPriotiry = '',
    this.vechBlack = '',
    this.truckBlack = '',
    this.colourCd = '',
    this.grnNo = '',
    this.grnDt = '',
    this.grnQty = '',
    this.uniqueRowId = '',
  });

  factory TransporterIndent.fromJson(Map<String, dynamic> json) =>
      TransporterIndent(
        metadata: Metadata.fromJson(
          json['__metadata'] == null ? {} : json['__metadata'],
        ),
        orderId: json['OrderId'] == null ? '' : json['OrderId'],
        indStatus: json['IndStatus'] == null ? '' : json['IndStatus'],
        srcLoc: json['SrcLoc'] == null ? '' : json['SrcLoc'],
        distLoc: json['DistLoc'] == null ? '' : json['DistLoc'],
        city: json['City'] == null ? '' : json['City'],
        distName: json['DistName'] == null ? '' : json['DistName'],
        srcName: json['SrcName'] == null ? '' : json['SrcName'],
        category: json['Category'] == null ? '' : json['Category'],
        pickDate: json['PickDate'] == null ? '' : json['PickDate'],
        pickTime: json['PickTime'] == null ? '' : json['PickTime'],
        skuCnt: json['SkuCnt'] == null ? '' : json['SkuCnt'],
        baseWeight: json['BaseWeight'] == null ? '' : json['BaseWeight'],
        baseQty: json['BaseQty'] == null ? '' : json['BaseQty'],
        baseTte: json['BaseTte'] == null ? '' : json['BaseTte'],
        tte: json['Tte'] == null ? '' : json['Tte'],
        truckType: json['TruckType'] == null ? '' : json['TruckType'],
        vsart: json['Vsart'] == null ? '' : json['Vsart'],
        market: json['Market'] == null ? '' : json['Market'],
        movement: json['Movement'] == null ? '' : json['Movement'],
        subMovement: json['SubMovement'] == null ? '' : json['SubMovement'],
        status: json['Status'] == null ? '' : json['Status'],
        ername: json['Ername'] == null ? '' : json['Ername'],
        oth1: json['Oth1'] == null ? '' : json['Oth1'],
        oth2: json['Oth2'] == null ? '' : json['Oth2'],
        oth3: json['Oth3'] == null ? '' : json['Oth3'],
        oth4: json['Oth4'] == null ? '' : json['Oth4'],
        oth5: json['Oth5'] == null ? '' : json['Oth5'],
        matnr: json['Matnr'] == null ? '' : json['Matnr'],
        maktx: json['Maktx'] == null ? '' : json['Maktx'],
        line: json['Line'] == null ? '' : json['Line'],
        unit: json['Unit'] == null ? '' : json['Unit'],
        shipment: json['Shipment'] == null ? '' : json['Shipment'],
        mode: json['Mode'] == null ? '' : json['Mode'],
        spotBill: json['SpotBill'] == null ? '' : json['SpotBill'],
        shipStatus: json['ShipStatus'] == null ? '' : json['ShipStatus'],
        delOrder: json['DelOrder'] == null ? '' : json['DelOrder'],
        delStatus: json['DelStatus'] == null ? '' : json['DelStatus'],
        docType: json['DocType'] == null ? '' : json['DocType'],
        transCd: json['TransCd'] == null ? '' : json['TransCd'],
        trnasName: json['TrnasName'] == null ? '' : json['TrnasName'],
        scac: json['Scac'] == null ? '' : json['Scac'],
        utlTte: json['UtlTte'] == null ? '' : json['UtlTte'],
        utlWeight: json['UtlWeight'] == null ? '' : json['UtlWeight'],
        utlWt: json['UtlWt'] == null ? '' : json['UtlWt'],
        spotBid: json['SpotBid'] == null ? '' : json['SpotBid'],
        billTo: json['BillTo'] == null ? '' : json['BillTo'],
        billToNm: json['BillToNm'] == null ? '' : json['BillToNm'],
        sapCarrier: json['SapCarrier'] == null ? '' : json['SapCarrier'],
        matnrTb: json['MatnrTb'] == null ? '' : json['MatnrTb'],
        tbQty: json['TbQty'] == null ? '' : json['TbQty'],
        matnrFl: json['MatnrFl'] == null ? '' : json['MatnrFl'],
        flQty: json['FlQty'] == null ? '' : json['FlQty'],
        ttType: json['TtType'] == null ? '' : json['TtType'],
        relQty: json['RelQty'] == null ? '' : json['RelQty'],
        postStatus: json['PostStatus'] == null ? '' : json['PostStatus'],
        postMsg: json['PostMsg'] == null ? '' : json['PostMsg'],
        errStatus: json['ErrStatus'] == null ? '' : json['ErrStatus'],
        errLog: json['ErrLog'] == null ? '' : json['ErrLog'],
        vtweg: json['Vtweg'] == null ? '' : json['Vtweg'],
        subMove: json['SubMove'] == null ? '' : json['SubMove'],
        turckNo: json['TurckNo'] == null ? '' : json['TurckNo'],
        diverNo: json['DiverNo'] == null ? '' : json['DiverNo'],
        bbnd: json['Bbnd'] == null ? '' : json['Bbnd'],
        oldCode: json['OldCode'] == null ? '' : json['OldCode'],
        lrNo: json['LrNo'] == null ? '' : json['LrNo'],
        lrDt: json['LrDt'] == null ? '' : json['LrDt'],
        pErdat: json['PErdat'] == null ? '' : json['PErdat'],
        pErtype: json['PErtype'] == null ? '' : json['PErtype'],
        pPickTp: json['PPickTp'] == null ? '' : json['PPickTp'],
        pMove: json['PMove'] == null ? '' : json['PMove'],
        pSegm: json['PSegm'] == null ? '' : json['PSegm'],
        pCatg: json['PCatg'] == null ? '' : json['PCatg'],
        pType: json['PType'] == null ? '' : json['PType'],
        tokenId: json['TokenId'] == null ? '' : json['TokenId'],
        pSrc: json['PSrc'] == null ? '' : json['PSrc'],
        pAction: json['PAction'] == null ? '' : json['PAction'],
        pTrans: json['PTrans'] == null ? '' : json['PTrans'],
        ttf: json['Ttf'] == null ? '' : json['Ttf'],
        respDt: json['RespDt'] == null ? '' : json['RespDt'],
        respTm: json['RespTm'] == null ? '' : json['RespTm'],
        respUser: json['RespUser'] == null ? '' : json['RespUser'],
        rank: json['Rank'] == null ? '' : json['Rank'],
        transitTm: json['TransitTm'] == null ? '' : json['TransitTm'],
        bidAmount: json['BidAmount'] == null ? '' : json['BidAmount'],
        remark: json['Remark'] == null ? '' : json['Remark'],
        spbitId: json['SpbitId'] == null ? '' : json['SpbitId'],
        statusCd: json['StatusCd'] == null ? '' : json['StatusCd'],
        pickDtTnt: json['PickDtTnt'] == null ? '' : json['PickDtTnt'],
        pickTmTnt: json['PickTmTnt'] == null ? '' : json['PickTmTnt'],
        setType: json['SetType'] == null ? '' : json['SetType'],
        invStatus: json['InvStatus'] == null ? '' : json['InvStatus'],
        tisStatus: json['TisStatus'] == null ? '' : json['TisStatus'],
        gtInDt: json['GtInDt'] == null ? '' : json['GtInDt'],
        gtInTm: json['GtInTm'] == null ? '' : json['GtInTm'],
        wbInDt: json['WbInDt'] == null ? '' : json['WbInDt'],
        wbInTm: json['WbInTm'] == null ? '' : json['WbInTm'],
        invNo: json['InvNo'] == null ? '' : json['InvNo'],
        delNo: json['DelNo'] == null ? '' : json['DelNo'],
        aubel: json['Aubel'] == null ? '' : json['Aubel'],
        auposnr: json['Auposnr'] == null ? '' : json['Auposnr'],
        fkdat: json['Fkdat'] == null ? '' : json['Fkdat'],
        fkart: json['Fkart'] == null ? '' : json['Fkart'],
        invVal: json['InvVal'] == null ? '' : json['InvVal'],
        invTax: json['InvTax'] == null ? '' : json['InvTax'],
        ewayBill: json['EwayBill'] == null ? '' : json['EwayBill'],
        freightValue: json['FreightValue'] == null ? '' : json['FreightValue'],
        insuranceVal: json['InsuranceVal'] == null ? '' : json['InsuranceVal'],
        netWeight: json['NetWeight'] == null ? '' : json['NetWeight'],
        grossweight: json['Grossweight'] == null ? '' : json['Grossweight'],
        preShipment: json['PreShipment'] == null ? '' : json['PreShipment'],
        preShipmentDt: json['PreShipmentDt'] == null ? '' : json['PreShipmentDt'],
        shippingBillno: json['ShippingBillno'] == null ? '' : json['ShippingBillno'],
        shippingBilldt: json['ShippingBilldt'] == null ? '' : json['ShippingBilldt'],
        hsnCode: json['HsnCode'] == null ? '' : json['HsnCode'],
        tubeMatr: json['TubeMatr'] == null ? '' : json['TubeMatr'],
        flapMatnr: json['FlapMatnr'] == null ? '' : json['FlapMatnr'],
        tMode: json['TMode'] == null ? '' : json['TMode'],
        ewayBillDt: json['EwayBillDt'] == null ? '' : json['EwayBillDt'],
        stoNo: json['StoNo'] == null ? '' : json['StoNo'],
        stoDt: json['StoDt'] == null ? '' : json['StoDt'],
        invQty: json['InvQty'] == null ? '' : json['InvQty'],
        scanQty: json['ScanQty'] == null ? '' : json['ScanQty'],
        invCnt: json['InvCnt'] == null ? '' : json['InvCnt'],
        etaDt: json['EtaDt'] == null ? '' : json['EtaDt'],
        etaTm: json['EtaTm'] == null ? '' : json['EtaTm'],
        tendCont: json['TendCont'] == null ? '' : json['TendCont'],
        seal: json['Seal'] == null ? '' : json['Seal'],
        shortRec: json['ShortRec'] == null ? '' : json['ShortRec'],
        transTmPlan: json['TransTmPlan'] == null ? '' : json['TransTmPlan'],
        transTmActul: json['TransTmActul'] == null ? '' : json['TransTmActul'],
        salesInv: json['SalesInv'] == null ? '' : json['SalesInv'],
        ftUrl: json['FtUrl'] == null ? '' : json['FtUrl'],
        kmCoverd: json['KmCoverd'] == null ? '' : json['KmCoverd'],
        kmActual: json['KmActual'] == null ? '' : json['KmActual'],
        currTrkPos: json['CurrTrkPos'] == null ? '' : json['CurrTrkPos'],
        sapCarrCd: json['SapCarrCd'] == null ? '' : json['SapCarrCd'],
        pod: json['Pod'] == null ? '' : json['Pod'],
        enroute: json['Enroute'] == null ? '' : json['Enroute'],
        mobile: json['Mobile'] == null ? '' : json['Mobile'],
        ldTmDt: json['LdTmDt'] == null ? '' : json['LdTmDt'],
        ldTmTm: json['LdTmTm'] == null ? '' : json['LdTmTm'],
        loadCost: json['LoadCost'] == null ? '' : json['LoadCost'],
        clr1: json['Clr1'] == null ? '' : json['Clr1'],
        clr2: json['Clr2'] == null ? '' : json['Clr2'],
        clr3: json['Clr3'] == null ? '' : json['Clr3'],
        clr4: json['Clr4'] == null ? '' : json['Clr4'],
        clr5: json['Clr5'] == null ? '' : json['Clr5'],
        clr6: json['Clr6'] == null ? '' : json['Clr6'],
        clr7: json['Clr7'] == null ? '' : json['Clr7'],
        damage: json['Damage'] == null ? '' : json['Damage'],
        damageRes: json['DamageRes'] == null ? '' : json['DamageRes'],
        shortRes: json['ShortRes'] == null ? '' : json['ShortRes'],
        misSku: json['MisSku'] == null ? '' : json['MisSku'],
        sapStatus: json['SapStatus'] == null ? '' : json['SapStatus'],
        stkQty: json['StkQty'] == null ? '' : json['StkQty'],
        rcptQty: json['RcptQty'] == null ? '' : json['RcptQty'],
        trnsStk: json['TrnsStk'] == null ? '' : json['TrnsStk'],
        bayStatus: json['BayStatus'] == null ? '' : json['BayStatus'],
        chgAuth: json['ChgAuth'] == null ? '' : json['ChgAuth'],
        bayCd: json['BayCd'] == null ? '' : json['BayCd'],
        bayName: json['BayName'] == null ? '' : json['BayName'],
        reqCd: json['ReqCd'] == null ? '' : json['ReqCd'],
        reqDesc: json['ReqDesc'] == null ? '' : json['ReqDesc'],
        spbidRespDt: json['SpbidRespDt'] == null ? '' : json['SpbidRespDt'],
        spbidRespTm: json['SpbidRespTm'] == null ? '' : json['SpbidRespTm'],
        spbidDistance: json['SpbidDistance'] == null ? '' : json['SpbidDistance'],
        spbidSrlno: json['SpbidSrlno'] == null ? '' : json['SpbidSrlno'],
        spbidWinner: json['SpbidWinner'] == null ? '' : json['SpbidWinner'],
        despPriotiry: json['DespPriotiry'] == null ? '' : json['DespPriotiry'],
        vechBlack: json['VechBlack'] == null ? '' : json['VechBlack'],
        truckBlack: json['TruckBlack'] == null ? '' : json['TruckBlack'],
        colourCd: json['ColourCd'] == null ? '' : json['ColourCd'],
        grnNo: json['GrnNo'] == null ? '' : json['GrnNo'],
        grnDt: json['GrnDt'] == null ? '' : json['GrnDt'],
        grnQty: json['GrnQty'] == null ? '' : json['GrnQty'],
        uniqueRowId: json['uniqueRowId'] == null ? '' : json['uniqueRowId'],
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
        id: json['id'] == null ? '' : json['id'],
        uri: json['uri'] == null ? '' : json['uri'],
        type: json['type'] == null ? '' : json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uri': uri,
        'type': type,
      };
}
