import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jk_otm/Urls/url_holder.dart';
import 'package:jk_otm/models/active_trips_model.dart';
import 'package:jk_otm/models/dealers_detail_tertiary_model.dart';
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
}
