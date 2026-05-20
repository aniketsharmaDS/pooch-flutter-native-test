enum InviteStatusFilter { pending, accepted }

extension InviteStatusFilterQuery on InviteStatusFilter {
  String toQueryValue() {
    switch (this) {
      case InviteStatusFilter.pending:
        return 'pending';
      case InviteStatusFilter.accepted:
        return 'accepted';
    }
  }
}
