import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/domain/models/user.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_state.dart';
import 'package:poochcare/core/widgets/cards/app_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthStoreBloc, AuthStoreState, User?>(
      selector: (AuthStoreState state) => state.user,
      builder: (BuildContext context, User? user) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText.h1(
                'User',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              AppText.bodyM(user?.name ?? '-'),
              AppText.bodyS(
                user?.email ?? '-',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}
