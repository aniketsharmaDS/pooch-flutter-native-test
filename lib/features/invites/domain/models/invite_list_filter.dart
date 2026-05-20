enum InviteListFilter { all, sent, received }

extension InviteListFilterQuery on InviteListFilter {
  String? toQueryValue() {
    switch (this) {
      case InviteListFilter.all:
        return null;
      case InviteListFilter.sent:
        return 'sent';
      case InviteListFilter.received:
        return 'received';
    }
  }
}
