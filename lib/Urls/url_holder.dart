class UrlHolderLoan {
  // static const baseUrl = "https://dc6c-202-144-62-131.ngrok-free.app/api/";
//// quality or development
  // static const baseUrl = "http://10.10.10.129:7000/api/";
  //// production
  static const baseUrl = "https://etms-dev.jktyre.co.in/api/";
  // static const baseUrl = "https://tms.jktyre.co.in/api/";
  //https://tms.jktyre.co.in/
  // static const baseUrl = "https://82a0-202-144-62-131.ngrok-free.app//api/";
//
  static const login = "v1/user/login";
  static const rolesAndModules = "v1/user/auth/rolesandmodules";
  static const logout = "v1/user/logout";
  static const openDomesticIndents = "v1/indent/domestic/indents/open";

  /// Approve / reject domestic indents
  static const approveRejectDomesticIndents =
      "v1/indent/domestic/indents/approvereject";

  /// Mass update tentative pickup date & time for open domestic indents
  /// POST - body:
  /// [
  ///   {
  ///     "shipment": "SH1011250010",
  ///     "pickDate": "2025-04-03",
  ///     "pickTime": "04:24:00"
  ///   }
  /// ]
  static const openDomesticIndentsMassUpdate =
      "v1/indent/domestic/indents/open/massupdate";

  /// Fetch approved domestic indents
  static const approvedDomesticIndents = "v1/indent/domestic/indents/approved";

  /// Fetch master truck data
  static const masterTruck = "v1/master/truck";
  static const masterLicenseNumber = "v1/master/driver";
  static const masterTransporter = "v1/master/transporter/";

  /// Assign truck and driver to domestic indents
  static const assignTruckDriver =
      "v1/indent/domestic/indents/assigntruckdriver";

  /// Fetch source locations
  static const sourceLocations = "v1/user/auth/locations/source";
  static const destinationLocations = "v1/user/auth/locations/destination";

  /// Fetch all indents with search filters
  static const allDomesticIndents = "v1/indent/domestic/indents/all";

  /// Tertiary: service provider depots
  static const tertiaryServiceProviderDepots =
      "v1/tertiary/serviceprovider/depots";

  /// Tertiary: service provider active trips (query: location)
  static const tertiaryServiceProviderActiveTrips =
      "v1/tertiary/serviceprovider/trips/active";

  /// Tertiary: service provider all trips (query: location)
  static const tertiaryServiceProviderAllTrips =
      "v1/tertiary/serviceprovider/trips/all";

  /// Tertiary: single trip by id (query: tripId)
  static const tertiaryServiceProviderTrip =
      "v1/tertiary/serviceprovider/trips/trip";
}
