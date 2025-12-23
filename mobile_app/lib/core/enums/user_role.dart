/// User roles in the system
enum UserRole {
  user, // Regular customer
  merchant, // Business owner
  admin, // System administrator
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.user:
        return 'User';
      case UserRole.merchant:
        return 'Merchant';
      case UserRole.admin:
        return 'Admin';
    }
  }

  List<Permission> get defaultPermissions {
    switch (this) {
      case UserRole.user:
        return [
          Permission.viewBusinesses,
          Permission.bookTickets,
          Permission.writeReviews,
          Permission.viewOffers,
          Permission.earnLoyaltyPoints,
        ];
      case UserRole.merchant:
        return [
          ...UserRole.user.defaultPermissions,
          Permission.manageOwnBusiness,
          Permission.viewOwnAnalytics,
          Permission.replyToReviews,
          Permission.manageOffers,
          Permission.manageQueue,
        ];
      case UserRole.admin:
        return Permission.values; // All permissions
    }
  }
}

/// System permissions
enum Permission {
  // User permissions
  viewBusinesses,
  bookTickets,
  writeReviews,
  viewOffers,
  earnLoyaltyPoints,

  // Merchant permissions
  manageOwnBusiness,
  viewOwnAnalytics,
  replyToReviews,
  manageOffers,
  manageQueue,

  // Admin permissions
  manageAllBusinesses,
  viewAllAnalytics,
  verifyBusinesses,
  manageUsers,
  viewSystemLogs,
  configureSystem,
}
