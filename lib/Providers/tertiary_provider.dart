import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jk_otm/Urls/url_holder.dart';
import 'package:jk_otm/models/active_trips_model.dart';
import 'package:jk_otm/models/dealers_detail_tertiary_model.dart';
import 'package:jk_otm/models/invoice_detail_model.dart';
import 'package:jk_otm/models/tertiary_route_model.dart';
import 'package:jk_otm/utils/api_interface.dart';

class TertiaryProvider with ChangeNotifier {
  List<RouteTertiaryModel> depots = [];
  RouteTertiaryResponse? depotsResponse;
  bool isLoadingDepots = false;
  String? depotsError;

  List<ActiveTripModel> activeTrips = [];
  ActiveTripsResponse? activeTripsResponse;
  bool isLoadingActiveTrips = false;
  String? activeTripsError;

  List<ActiveTripModel> allTrips = [];
  ActiveTripsResponse? allTripsResponse;
  bool isLoadingAllTrips = false;
  String? allTripsError;

  DealersDetailResponse? tripDetailDealersResponse;
  bool isLoadingTripDetail = false;
  String? tripDetailError;

  /// GET tertiary trip for a specific [dealerCode] (same shape as trip detail).
  DealersDetailResponse? invoiceDetailResponse;
  bool isLoadingTripDealerDetail = false;
  String? tripDealerDetailError;

  /// GET tertiary dealer invoice detail for a specific [tripId], [dealerCode]
  /// and [invoiceNo].
  List<InvoiceDetailModel> invoiceDetail = [];
  bool isLoadingInvoiceDetail = false;
  String? invoiceDetailError;

  /// POST tertiary dealer document upload pre-signed URL.
  bool isLoadingDocumentUploadUrl = false;
  String? documentUploadUrlError;
  String? documentUploadPresignedUrl;
  String? documentUploadName;

  bool isUploadingDocumentBinary = false;
  String? documentBinaryUploadError;

  /// GET tertiary service provider depots.
  /// Parsed [RouteTertiaryResponse] is stored in [depotsResponse]; rows in [depots].
  Future<bool> fetchTertiaryServiceProviderDepots(BuildContext context) async {
    isLoadingDepots = true;
    depotsError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderDepots}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = RouteTertiaryResponse.fromJson(
          Map<String, dynamic>.from(response['data'] as Map),
        );
        depotsResponse = parsed;
        depots = parsed.data ?? [];
        log('depots: ${depots.length}');
        notifyListeners();
        return true;
      } else {
        depotsError =
            response['message'] as String? ?? 'Unable to fetch depots';
        showErrorToast(depotsError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      depotsError = 'An error occurred while fetching depots';
      showErrorToast(depotsError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingDepots = false;
      notifyListeners();
    }
  }

  /// GET tertiary service provider active trips for [location].
  /// Parsed [ActiveTripsResponse] is stored in [activeTripsResponse]; rows in [activeTrips].
  Future<bool> fetchTertiaryServiceProviderActiveTrips(
    BuildContext context, {
    required String location,
  }) async {
    isLoadingActiveTrips = true;
    activeTripsError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderActiveTrips}'
        '?location=${Uri.encodeQueryComponent(location)}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = ActiveTripsResponse.fromJson(
          Map<String, dynamic>.from(response['data'] as Map),
        );
        activeTripsResponse = parsed;
        activeTrips = parsed.data ?? [];
        notifyListeners();
        return true;
      } else {
        activeTripsError =
            response['message'] as String? ?? 'Unable to fetch active trips';
        showErrorToast(activeTripsError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      activeTripsError = 'An error occurred while fetching active trips';
      showErrorToast(activeTripsError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingActiveTrips = false;
      notifyListeners();
    }
  }

  /// GET tertiary service provider all trips for [location].
  /// Parsed [ActiveTripsResponse] is stored in [allTripsResponse]; rows in [allTrips].
  Future<bool> fetchTertiaryServiceProviderAllTrips(
    BuildContext context, {
    required String location,
  }) async {
    isLoadingAllTrips = true;
    allTripsError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderAllTrips}'
        '?location=${Uri.encodeQueryComponent(location)}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final parsed = ActiveTripsResponse.fromJson(
          Map<String, dynamic>.from(response['data'] as Map),
        );
        allTripsResponse = parsed;
        allTrips = parsed.data ?? [];
        notifyListeners();
        return true;
      } else {
        allTripsError =
            response['message'] as String? ?? 'Unable to fetch all trips';
        showErrorToast(allTripsError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      allTripsError = 'An error occurred while fetching all trips';
      showErrorToast(allTripsError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingAllTrips = false;
      notifyListeners();
    }
  }

  /// GET tertiary service provider trip by [tripId].
  /// Parsed [DealersDetailResponse] is stored in [tripDetailDealersResponse].
  Future<bool> fetchTertiaryServiceProviderTrip(
    BuildContext context, {
    required String tripId,
  }) async {
    isLoadingTripDetail = true;
    tripDetailError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderTrip}'
        '?tripId=${Uri.encodeQueryComponent(tripId)}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final body = Map<String, dynamic>.from(response['data'] as Map);
        final rawData = body['data'];
        if (rawData != null && rawData is! List) {
          if (rawData is Map) {
            body['data'] = [rawData];
          }
        }
        final parsed = DealersDetailResponse.fromJson(body);
        tripDetailDealersResponse = parsed;
        notifyListeners();
        return true;
      } else {
        tripDetailError =
            response['message'] as String? ?? 'Unable to fetch trip';
        showErrorToast(tripDetailError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      tripDetailError = 'An error occurred while fetching trip';
      showErrorToast(tripDetailError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingTripDetail = false;
      notifyListeners();
    }
  }

  /// GET tertiary service provider trip for [tripId] and [dealerCode].
  /// Parsed [DealersDetailResponse] is stored in [tripDealerDetailResponse].
  Future<bool> fetchTertiaryServiceProviderTripDealer(
    BuildContext context, {
    required String tripId,
    required String dealerCode,
  }) async {
    isLoadingTripDealerDetail = true;
    tripDealerDetailError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderTripDealer}'
        '?tripId=${Uri.encodeQueryComponent(tripId)}'
        '&dealerCode=${Uri.encodeQueryComponent(dealerCode)}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final body = Map<String, dynamic>.from(response['data'] as Map);
        final rawData = body['data'];
        if (rawData != null && rawData is! List) {
          if (rawData is Map) {
            body['data'] = [rawData];
          }
        }
        final parsed = DealersDetailResponse.fromJson(body);
        invoiceDetailResponse = parsed;
        notifyListeners();
        return true;
      } else {
        tripDealerDetailError =
            response['message'] as String? ?? 'Unable to fetch trip dealer';
        showErrorToast(tripDealerDetailError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      tripDealerDetailError = 'An error occurred while fetching trip dealer';
      showErrorToast(tripDealerDetailError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingTripDealerDetail = false;
      notifyListeners();
    }
  }

  /// GET tertiary service provider dealer invoice for [tripId], [dealerCode] and [invoiceNo].
  /// Parsed [InvoiceDetailModel] is stored in [invoiceDetail].
  Future<bool> fetchTertiaryServiceProviderTripDealerInvoice(
    BuildContext context, {
    required String tripId,
    required String dealerCode,
    required String invoiceNo,
  }) async {
    isLoadingInvoiceDetail = true;
    invoiceDetailError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderTripDealerInvoice}'
        '?tripId=${Uri.encodeQueryComponent(tripId)}'
        '&dealerCode=${Uri.encodeQueryComponent(dealerCode)}'
        '&invoiceNo=${Uri.encodeQueryComponent(invoiceNo)}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'GET',
        requiresAuth: true,
        context: context,
      );

      if (response['success'] == true && response['data'] != null) {
        final body = Map<String, dynamic>.from(response['data'] as Map);
        final rawData = body['data'];
        if (rawData != null && rawData is! List) {
          if (rawData is Map) {
            body['data'] = [rawData];
          }
        }

        final parsedResponse = InvoiceDetailResponse.fromJson(body);
        final items = parsedResponse.data;

        if (items.isNotEmpty) {
          invoiceDetail = items;
          // invoiceDetail = items.first;

          notifyListeners();
          return true;
        }

        invoiceDetailError = 'Unable to parse invoice detail';
        showErrorToast(invoiceDetailError!);
        notifyListeners();
        return false;
      } else {
        invoiceDetailError =
            response['message'] as String? ?? 'Unable to fetch invoice detail';
        showErrorToast(invoiceDetailError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      invoiceDetailError = 'An error occurred while fetching invoice detail';
      showErrorToast(invoiceDetailError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingInvoiceDetail = false;
      notifyListeners();
    }
  }

  /// POST tertiary service provider document upload URL for
  /// [tripId], [dealerCode], [documentId], [latitude], [longitude].
  /// On success, stores URL in [documentUploadPresignedUrl].
  Future<bool> fetchTertiaryServiceProviderTripDealerDocumentUploadUrl(
    BuildContext context, {
    required String tripId,
    required String dealerCode,
    // required String documentId,
    required String latitude,
    required String longitude,
    required List<int> bytes,
  }) async {
    isLoadingDocumentUploadUrl = true;
    documentUploadUrlError = null;
    notifyListeners();

    final url =
        '${UrlHolderLoan.baseUrl}${UrlHolderLoan.tertiaryServiceProviderTripDealerDocumentUploadUrl}';

    try {
      final response = await makeRequest(
        url: url,
        method: 'POST',
        requiresAuth: true,
        context: context,
        body: {
          'tripId': tripId,
          'dealerCode': dealerCode,
          'documentId': '1',
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response['success'] == true && response['data'] != null) {
        final body = Map<String, dynamic>.from(response['data'] as Map);
        if (body['success'] == true && body['data'] != null) {
          final data = Map<String, dynamic>.from(body['data'] as Map);
          documentUploadPresignedUrl = data['presignedUrl'] as String?;
          documentUploadName = data['documentName'] as String?;

          log('tanay documentUploadPresignedUrl: $documentUploadPresignedUrl');
          log('tanay documentUploadName: $documentUploadName');
          uploadDocumentBinaryToPresignedUrl(bytes: bytes);
          notifyListeners();
          return true;
        }

        documentUploadUrlError =
            body['message'] as String? ?? 'Unable to fetch upload URL';
        showErrorToast(documentUploadUrlError!);
        notifyListeners();
        return false;
      } else {
        documentUploadUrlError =
            response['message'] as String? ?? 'Unable to fetch upload URL';
        showErrorToast(documentUploadUrlError!);
        notifyListeners();
        return false;
      }
    } catch (e) {
      documentUploadUrlError = 'An error occurred while fetching upload URL';
      showErrorToast(documentUploadUrlError!);
      notifyListeners();
      return false;
    } finally {
      isLoadingDocumentUploadUrl = false;
      notifyListeners();
    }
  }

  /// PUT raw [bytes] to [documentUploadPresignedUrl] (e.g. S3 presigned URL).
  /// Call after [fetchTertiaryServiceProviderTripDealerDocumentUploadUrl] succeeds.
  /// Uses only the presigned URL (no app auth headers).
  ///
  /// Returns [ok] and [response] when the server replied (inspect status/body);
  /// [response] is null only when there was no URL or a network error before a reply.
  Future<({bool ok, http.Response? response})>
      uploadDocumentBinaryToPresignedUrl({
    required List<int> bytes,
    String contentType = 'image/jpeg',
  }) async {
    final url = documentUploadPresignedUrl;
    if (url == null || url.isEmpty) {
      documentBinaryUploadError = 'No upload URL available';
      showErrorToast(documentBinaryUploadError!);
      notifyListeners();
      return (ok: false, response: null);
    }

    isUploadingDocumentBinary = true;
    documentBinaryUploadError = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse(url),
        body: bytes,
        headers: {'Content-Type': contentType},
      );

      log('rituu status code: ${jsonEncode(response.statusCode)}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // log('rituu response: ${jsonEncode(response.body)}');
        return (ok: true, response: response);
      }

      documentBinaryUploadError = 'Upload failed (HTTP ${response.statusCode})';
      showErrorToast(documentBinaryUploadError!);
      return (ok: false, response: response);
    } catch (e) {
      documentBinaryUploadError =
          'An error occurred while uploading the document';
      showErrorToast(documentBinaryUploadError!);
      return (ok: false, response: null);
    } finally {
      isUploadingDocumentBinary = false;
      notifyListeners();
    }
  }
}
