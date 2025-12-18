/// Utility class to map module codes to their corresponding asset images
class ImageIconSelector {
  /// Maps module codes to their asset paths
  static const Map<String, String> _codeAssetMap = {
    'FTMS': 'assets/fleet-master.svg',
    'USERMGMT': 'assets/user-master.svg',
    'LOCMST': 'assets/location-master.svg',
    'ROLEMST': 'assets/role-master.svg',
    'WEGHIN': 'assets/weight-in.svg',
    'WEGHOUT': 'assets/weight-out.svg',
    'VECHREP': 'assets/vehicle-reporting.svg',
    'GATEIN': 'assets/gate-in.svg',
    'GATEOUT': 'assets/gate-out.svg',
    'ORDREL': 'assets/orders.svg',
    'RELSKU': 'assets/release-sku.svg',
    'SHIPDOM': 'assets/shipment-domestic.svg',
    'INDREQMAN': 'assets/indent-request-manual.svg',
    'OPENIND': 'assets/open-indent.svg',
    'ASGNTRK': 'assets/assign-truck.svg',
    'UPLDPR': 'assets/upload-utility.svg',
    'UPLDSC': 'assets/upload-utility-secondary.svg',
    'SPOTBID': 'assets/spot-bid.svg',
    'SPOTBIDTND': 'assets/spot-bid-tender.svg',
    'INBSHIP': 'assets/inbound-shipment.svg',
    'SHIPTRCK': 'assets/shipment-tracking.svg',
    'INDREQSEC': 'assets/indent-request-creation.svg',
    'EXP': 'assets/export.svg',
    'UNIND': 'assets/union_Indent.svg',
    'LRDTLS': 'assets/lr-details.svg',
    'INVOICES': 'assets/invoice.svg',
    'CARRINV': 'assets/orders.svg',
    'COSDINV': 'assets/consolidated_Invoices.svg',
    'ALLIND': 'assets/all-indents.svg',
  };

  /// Default asset path when code is not found
  static const String defaultAsset = 'assets/info.svg';

  /// Get the asset path for a given code
  ///
  /// [code] - The module code (e.g., 'FTMS', 'USERMGMT')
  /// Returns the asset path string, or defaultAsset if code is not found
  static String getAssetPath(String code) {
    // Try exact match first (uppercase)
    final upperCode = code.toUpperCase();
    if (_codeAssetMap.containsKey(upperCode)) {
      return _codeAssetMap[upperCode]!;
    }

    // Return default asset if no match found
    return defaultAsset;
  }

  /// Check if a code has a mapped asset
  static bool hasAssetMapping(String code) {
    final upperCode = code.toUpperCase();
    return _codeAssetMap.containsKey(upperCode);
  }

  /// Get all available codes that have asset mappings
  static List<String> getAvailableCodes() {
    return _codeAssetMap.keys.toList();
  }
}
