import 'dart:convert';

UserRoleResponse userRoleResponseFromJson(String str) =>
    UserRoleResponse.fromJson(json.decode(str));

String userRoleResponseToJson(UserRoleResponse data) =>
    json.encode(data.toJson());

class UserRoleResponse {
  final bool success;
  final String message;
  final List<UserRoleModel> data;

  UserRoleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserRoleResponse.fromJson(Map<String, dynamic> json) =>
      UserRoleResponse(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: (json['data'] as List)
            .map((e) => UserRoleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class UserRoleModel {
  final String code;
  final String description;
  final List<UserRoleModule> modules;

  UserRoleModel({
    required this.code,
    required this.description,
    required this.modules,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        code: json['code'] as String,
        description: json['description'] as String,
        modules: (json['modules'] as List)
            .map((e) => UserRoleModule.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'description': description,
        'modules': modules.map((e) => e.toJson()).toList(),
      };

  
}

class UserRoleModule {
  final String code;
  final String description;
  final String summary;
  final String path;
  final List<UserRoleModule> children;

  UserRoleModule({
    required this.code,
    required this.description,
    required this.summary,
    required this.path,
    required this.children,
  });

  factory UserRoleModule.fromJson(Map<String, dynamic> json) =>
      UserRoleModule(
        code: json['code'] as String,
        description: json['description'] as String,
        summary: json['summary'] as String? ?? '',
        path: json['path'] as String? ?? '',
        children: (json['children'] as List)
            .map((e) => UserRoleModule.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'description': description,
        'summary': summary,
        'path': path,
        'children': children.map((e) => e.toJson()).toList(),
      };
}
