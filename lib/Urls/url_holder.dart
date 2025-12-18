class UrlHolderLoan {
  // static const baseUrl = "https://dc6c-202-144-62-131.ngrok-free.app/api/";
//// quality or development
  // static const baseUrl = "http://10.10.10.129:7000/api/";
  //// production
  static const baseUrl = "https://etms-dev.jktyre.co.in/api/";
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
}
