import '../enums/user_role.dart';

/// Permission service to check user permissions
class PermissionService {
  /// Check if user has specific permission
  bool hasPermission(UserRole userRole, Permission permission) {
    final permissions = userRole.defaultPermissions;
    return permissions.contains(permission);
  }

  /// Check if user has any of the given permissions
  bool hasAnyPermission(UserRole userRole, List<Permission> permissions) {
    return permissions.any((p) => hasPermission(userRole, p));
  }

  /// Check if user has all of the given permissions
  bool hasAllPermissions(UserRole userRole, List<Permission> permissions) {
    return permissions.every((p) => hasPermission(userRole, p));
  }

  /// Check if user can access merchant features
  bool canAccessMerchantFeatures(UserRole userRole) {
    return userRole == UserRole.merchant || userRole == UserRole.admin;
  }

  /// Check if user can access admin features
  bool canAccessAdminFeatures(UserRole userRole) {
    return userRole == UserRole.admin;
  }

  /// Get user's home route based on role
  String getHomeRoute(UserRole userRole) {
    switch (userRole) {
      case UserRole.user:
        return '/home';
      case UserRole.merchant:
        return '/merchant-dashboard';
      case UserRole.admin:
        return '/admin-dashboard';
    }
  }
}
