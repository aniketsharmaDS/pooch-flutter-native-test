import 'package:flutter/material.dart';

class CommunityService {
  static String getFeedStatus(String status, BuildContext context) {
    switch (status) {
      case 'DRAFT':
        return 'Draft';
      case 'PENDING_REVIEW':
      case 'UNDER_REVIEW':
        return 'In Review';
      case 'APPROVED':
        return 'Approved';
      case 'REJECTED':
        return 'Rejected';
      default:
        return status;
    }
  }
}
