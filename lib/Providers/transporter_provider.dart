import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jk_otm/Urls/url_holder.dart';
import 'package:jk_otm/models/transporter_indents_model.dart';
import 'package:jk_otm/models/open_indents_model.dart';
import 'package:jk_otm/utils/api_interface.dart';

class TransporterProvider with ChangeNotifier {
  List<TransporterIndent> openIndents = [];
  bool isLoadingOpenIndents = false;
  String? openIndentsError;
  bool isProcessingUnionApproval = false;
  String? unionApprovalMessage;
  OpenIndentsResponse? openIndentsResponse;
  OpenIndentsResponse? openIndentsResponseForMassUpdate;

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
}
