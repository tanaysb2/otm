import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jk_otm/Urls/url_holder.dart';
import 'package:jk_otm/models/driver_license_model.dart';
import 'package:jk_otm/models/transporter_indents_model.dart';
import 'package:jk_otm/models/open_indents_model.dart';
import 'package:jk_otm/models/vehicle_number_model.dart';
import 'package:jk_otm/models/transporter_model.dart';
import 'package:jk_otm/models/source_loc_model.dart';
import 'package:jk_otm/utils/api_interface.dart';

class TransporterProvider with ChangeNotifier {
  List<TransporterIndent> openIndents = [];
  bool isLoadingOpenIndents = false;
  String? openIndentsError;
  bool isProcessingUnionApproval = false;
  String? unionApprovalMessage;
  OpenIndentsResponse? openIndentsResponse;
  OpenIndentsResponse? openIndentsResponseForMassUpdate;
  List<TransporterIndent> assignTruck = [];
  bool isLoadingApprovedIndents = false;
  String? approvedIndentsError;
  List<VehicleNumberModel> trucks = [];
  List<DriverMaster> driverLicenseList = [];
  bool isLoadingTrucks = false;
  String? trucksError;
  List<TransporterMaster> transporters = [];
  bool isLoadingTransporters = false;
  String? transportersError;
  bool isAssigningTruckDriver = false;
  String? assignTruckDriverError;
  OpenIndentsResponse? assignTruckDriverResponse;
  List<LocationSourceData> sourceLocations = [];
  List<LocationSourceData> destinationLocations = [];
  bool isLoadingSourceLocations = false;
  String? sourceLocationsError;
  List<TransporterIndent> allIndentsSearchResults = [];
  bool isLoadingAllIndents = false;
  String? allIndentsError;

  /// Fetch list of open domestic indents for the logged-in transporter
  Future<void> fetchOpenDomesticIndents(BuildContext context) async {
    isLoadingOpenIndents = true;
    openIndentsError = null;
    notifyListeners();

    final url = '${UrlHolderLoan.baseUrl}${UrlHolderLoan.openDomesticIndents}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = TransporterIndentsResponse.fromJson(response['data']);
        openIndents = parsed.data;
        notifyListeners();
      } else {
        openIndentsError =
            response['message'] ?? 'Unable to fetch open indents';
        showErrorToast(openIndentsError!);
        notifyListeners();
      }
    } catch (e) {
      openIndentsError = 'An error occurred while fetching indents';
      showErrorToast(openIndentsError!);
      notifyListeners();
    } finally {
      isLoadingOpenIndents = false;
      notifyListeners();
    }
  }

  Future<bool> approveRejectDomesticIndents(
    BuildContext context, {
    required List<String> shipmentIds,
    required String actionType,
  }) async {
    isProcessingUnionApproval = true;
    unionApprovalMessage = null;
    notifyListeners();

    final orderlistParam = Uri.encodeQueryComponent(shipmentIds.join(','));
    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.approveRejectDomesticIndents}?orderlist=$orderlistParam&actionType=$actionType';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      log("${response['data']} datdaatd");

      if (response['success'] == true && response['data'] != null) {
        final txopenIndentsResponse =
            OpenIndentsResponse.fromJson(response['data']);

        openIndentsResponse = txopenIndentsResponse;
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      unionApprovalMessage =
          'An error occurred while approving/rejecting indents';
      showErrorToast(unionApprovalMessage!);
      return false;
    } finally {
      isProcessingUnionApproval = false;
      notifyListeners();
    }
  }

  /// Mass update tentative pickup date & time for one or more shipments.
  ///
  /// [updates] should be a list of maps in the form:
  /// [
  ///   {
  ///     "shipment": "SH1011250010",
  ///     "pickDate": "2025-04-03",
  ///     "pickTime": "04:24:00"
  ///   },
  ///   ...
  /// ]
  ///
  /// Returns parsed [OpenIndentsResponse] (from `open_indents_model.dart`)
  /// when the API responds with success, otherwise `null`.
  Future<bool> massUpdateOpenDomesticIndents(
    BuildContext context, {
    required List<Map<String, String>> updates,
  }) async {
    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.openDomesticIndentsMassUpdate}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'POST',
        body: updates,
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final result = OpenIndentsResponse.fromJson(response['data']);
        openIndentsResponseForMassUpdate = result;
        notifyListeners();
        return true;
      } else {
        final message =
            response['message'] ?? 'Unable to mass update open indents';
        openIndentsError = message;
        showErrorToast(message);
        notifyListeners();
        return false;
      }
    } catch (e) {
      openIndentsError = 'An error occurred while mass updating open indents';
      showErrorToast(openIndentsError!);
      notifyListeners();
      return false;
    }
  }

  /// Fetch list of approved domestic indents for the logged-in transporter
  Future<void> fetchApprovedDomesticIndents(BuildContext context) async {
    isLoadingApprovedIndents = true;
    approvedIndentsError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.approvedDomesticIndents}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = TransporterIndentsResponse.fromJson(response['data']);
        assignTruck = parsed.data;
        notifyListeners();
      } else {
        approvedIndentsError =
            response['message'] ?? 'Unable to fetch approved indents';
        showErrorToast(approvedIndentsError!);
        notifyListeners();
      }
    } catch (e) {
      approvedIndentsError =
          'An error occurred while fetching approved indents';
      showErrorToast(approvedIndentsError!);
      notifyListeners();
    } finally {
      isLoadingApprovedIndents = false;
      notifyListeners();
    }
  }

  /// Fetch list of trucks from master truck data
  Future<void> fetchMasterTrucks(BuildContext context,
      {String action = 'A'}) async {
    isLoadingTrucks = true;
    trucksError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.masterTruck}?action=$action';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = VehicleNumberResponse.fromJson(response['data']);
        trucks = parsed.data;

        log("${trucks.length} length");
        log("${trucks[0].truckNo} length");
        notifyListeners();
      } else {
        trucksError = response['message'] ?? 'Unable to fetch trucks';
        showErrorToast(trucksError!);
        notifyListeners();
      }
    } catch (e) {
      trucksError = 'An error occurred while fetching trucks';
      showErrorToast(trucksError!);
      notifyListeners();
    } finally {
      isLoadingTrucks = false;
      notifyListeners();
    }
  }

  Future<void> fetchMasterDriverLicense(BuildContext context,
      {String action = 'A'}) async {
    isLoadingTrucks = true;
    trucksError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.masterLicenseNumber}?action=$action';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = DriverLicenseResponse.fromJson(response['data']);
        driverLicenseList = parsed.data;

        log("${driverLicenseList.length} length");
        log("${driverLicenseList[0].drivLicNo} length");
        notifyListeners();
      } else {
        trucksError = response['message'] ?? 'Unable to fetch trucks';
        showErrorToast(trucksError!);
        notifyListeners();
      }
    } catch (e) {
      trucksError = 'An error occurred while fetching trucks';
      showErrorToast(trucksError!);
      notifyListeners();
    } finally {
      isLoadingTrucks = false;
      notifyListeners();
    }
  }

  /// Fetch list of transporters from master transporter data
  Future<void> fetchMasterTransporters(BuildContext context) async {
    isLoadingTransporters = true;
    transportersError = null;
    notifyListeners();

    final url = '${UrlHolderLoan.baseUrl}${UrlHolderLoan.masterTransporter}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = TransporterResponse.fromJson(response['data']);
        transporters = parsed.data;

        log("${transporters.length} transporters length");
        if (transporters.isNotEmpty) {
          log("${transporters[0].transCode} first transporter code");
        }
        notifyListeners();
      } else {
        transportersError =
            response['message'] ?? 'Unable to fetch transporters';
        showErrorToast(transportersError!);
        notifyListeners();
      }
    } catch (e) {
      transportersError = 'An error occurred while fetching transporters';
      showErrorToast(transportersError!);
      notifyListeners();
    } finally {
      isLoadingTransporters = false;
      notifyListeners();
    }
  }

  /// Assign truck and driver to domestic indents
  ///
  /// [orderlist] can be a single order ID or comma-separated list of order IDs
  /// [truckNo] is the truck number to assign
  /// [driverNo] is the driver license number to assign
  ///
  /// Returns `true` if successful, `false` otherwise.
  /// Response is stored in [assignTruckDriverResponse].
  Future<bool> assignTruckDriverToIndents(
    BuildContext context, {
    required String orderlist,
    required String truckNo,
    required String driverNo,
  }) async {
    isAssigningTruckDriver = true;
    assignTruckDriverError = null;
    assignTruckDriverResponse = null;
    notifyListeners();

    final orderlistParam = Uri.encodeQueryComponent(orderlist);
    final truckNoParam = Uri.encodeQueryComponent(truckNo);
    final driverNoParam = Uri.encodeQueryComponent(driverNo);
    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.assignTruckDriver}?orderlist=$orderlistParam&truckNo=$truckNoParam&driverNo=$driverNoParam';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = OpenIndentsResponse.fromJson(response['data']);
        assignTruckDriverResponse = parsed;
        log("${assignTruckDriverResponse?.data.length} checking if right");
        log("${assignTruckDriverResponse?.data[0].postMsg} checking if right");
        notifyListeners();
        return true;
      } else {
        assignTruckDriverError =
            response['message'] ?? 'Unable to assign truck and driver';
        showErrorToast(assignTruckDriverError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      assignTruckDriverError =
          'An error occurred while assigning truck and driver';
      showErrorToast(assignTruckDriverError!);
      notifyListeners();
      return false;
    } finally {
      isAssigningTruckDriver = false;
      notifyListeners();
    }
  }

  /// Fetch list of source locations
  Future<void> fetchSourceLocations(BuildContext context) async {
    isLoadingSourceLocations = true;
    sourceLocationsError = null;
    notifyListeners();

    final url = '${UrlHolderLoan.baseUrl}${UrlHolderLoan.sourceLocations}';

    final response = await makeRequest(
      url: url,
      method: 'GET',
      requiresAuth: true,
      context: context,
    );

    if (response['success'] == true && response['data'] != null) {
      final parsed = LocationResponse.fromJson(response['data']);
      sourceLocations = parsed.data;

      log("${sourceLocations.length} source locations length");

      notifyListeners();
    } else {
      sourceLocationsError =
          response['message'] ?? 'Unable to fetch source locations';
      showErrorToast(sourceLocationsError!);
      notifyListeners();
    }
  }

  Future<void> fetchDestinationLoc(BuildContext context) async {
    isLoadingSourceLocations = true;
    sourceLocationsError = null;
    notifyListeners();

    final url = '${UrlHolderLoan.baseUrl}${UrlHolderLoan.destinationLocations}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = LocationResponse.fromJson(response['data']);
        destinationLocations = parsed.data;

        log("${destinationLocations.length} desrination locations length");

        notifyListeners();
      } else {
        sourceLocationsError =
            response['message'] ?? 'Unable to fetch source locations';
        showErrorToast(sourceLocationsError!);
        notifyListeners();
      }
    } catch (e) {
      sourceLocationsError =
          'An error occurred while fetching source locations';
      showErrorToast(sourceLocationsError!);
      notifyListeners();
    } finally {
      isLoadingSourceLocations = false;
      notifyListeners();
    }
  }

  /// Search all domestic indents with filters
  ///
  /// [date] should be in YYYY-MM-DD format
  /// [dateComparison] should be "BF" (Before), "AF" (After), or "SM" (Same As)
  /// [source] comma-separated list of source location codes (optional)
  /// [destination] comma-separated list of destination location codes (optional)
  Future<bool> searchAllDomesticIndents(
    BuildContext context, {
    required String date,
    required String dateComparison,
    String? source,
    String? destination,
  }) async {
    isLoadingAllIndents = true;
    allIndentsError = null;
    allIndentsSearchResults = [];
    notifyListeners();

    // Build query parameters
    final queryParams = <String, String>{
      'date': date,
      'dateComparison': dateComparison,
    };

    if (source != null && source.isNotEmpty) {
      queryParams['source'] = source;
    }

    if (destination != null && destination.isNotEmpty) {
      queryParams['destination'] = destination;
    }

    // Build URL with query parameters
    final uri = Uri.parse(
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.allDomesticIndents}');
    final urlWithParams = uri.replace(queryParameters: queryParams).toString();

    try {
      final response = await makeRequest(
        url: urlWithParams,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = TransporterIndentsResponse.fromJson(response['data']);
        allIndentsSearchResults = parsed.data;
        notifyListeners();
        return true;
      } else {
        allIndentsError = response['message'] ?? 'Unable to search indents';
        showErrorToast(allIndentsError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      allIndentsError = 'An error occurred while searching indents';
      showErrorToast(allIndentsError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingAllIndents = false;
      notifyListeners();
    }
  }
}
