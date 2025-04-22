import 'package:comunidadesucv/features/communities/data/dto/user_info.dart';

class MembershipInfo {
  final UserInfo user;
  final String role;
  final int status;
  final int canCancelMembership;
  final int sendNotifications;
  final int showAtDashboard;
  final UserInfo? originatorUser;
  final String memberSince;
  final String? requestMessage;
  final String updatedAt;
  final String? lastVisit;

  MembershipInfo({
    required this.user,
    required this.role,
    required this.status,
    required this.canCancelMembership,
    required this.sendNotifications,
    required this.showAtDashboard,
    this.originatorUser,
    required this.memberSince,
    this.requestMessage,
    required this.updatedAt,
    this.lastVisit,
  });

  factory MembershipInfo.fromJson(Map<String, dynamic> json) {
    return MembershipInfo(
      user: UserInfo.fromJson(json['user']),
      role: json['role'],
      status: json['status'],
      canCancelMembership: json['can_cancel_membership'],
      sendNotifications: json['send_notifications'],
      showAtDashboard: json['show_at_dashboard'],
      originatorUser: json['originator_user'] != null
          ? UserInfo.fromJson(json['originator_user'])
          : null,
      memberSince: json['member_since'],
      requestMessage: json['request_message'],
      updatedAt: json['updated_at'],
      lastVisit: json['last_visit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'role': role,
      'status': status,
      'can_cancel_membership': canCancelMembership,
      'send_notifications': sendNotifications,
      'show_at_dashboard': showAtDashboard,
      'originator_user': originatorUser?.toJson(),
      'member_since': memberSince,
      'request_message': requestMessage,
      'updated_at': updatedAt,
      'last_visit': lastVisit,
    };
  }
}