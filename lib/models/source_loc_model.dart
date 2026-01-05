// Main response model
class LocationResponse {
  final bool success;
  final String message;
  final List<LocationSourceData> data;

  LocationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) =>
              LocationSourceData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

// Location model
class LocationSourceData {
  final String code;
  final String description;

  LocationSourceData({
    required this.code,
    required this.description,
  });

  factory LocationSourceData.fromJson(Map<String, dynamic> json) {
    return LocationSourceData(
      code: json['code'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Location(code: $code, description: $description)';
  }
}

// Example usage:
