import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TransitionDemoScreen extends StatelessWidget {
  const TransitionDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_TransitionDemoItem>[
      _TransitionDemoItem(
        title: 'Onboarding',
        icon: Icons.pets,
        destination: OnboardingTransitionRoute(),
      ),
      const _TransitionDemoItem(
        title: 'Configure Pooch',
        icon: Icons.tune,
        destination: ConfigurePoochTransitionRoute(),
      ),
      const _TransitionDemoItem(
        title: 'E-commerce',
        icon: Icons.shopping_cart,
        destination: EcommerceTransitionRoute(),
      ),
      const _TransitionDemoItem(
        title: 'Order Success',
        icon: Icons.check_circle,
        destination: OrderSuccessTransitionRoute(),
      ),
      const _TransitionDemoItem(
        title: 'Delivery Complete',
        icon: Icons.local_shipping,
        destination: DelieveryCompleteTransitionRoute(),
      ),
      const _TransitionDemoItem(
        title: 'Appointment',
        icon: Icons.calendar_today,
        destination: AppointmentTransitionRoute(),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFEDCF), Color(0xFFEBB945)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Text(
                  'Transition Screens',
                  style: TextStyle(
                    fontFamily: 'Gilroy500',
                    fontSize: 42,
                    color: Color(0xFF1F140B),
                    height: 1.0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.95,
                    children: items.map((item) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (_) => item.destination,
                          //   ),
                          // );
                          context.router.push(item.destination);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFFEDCF),
                                      Color(0xFFEBB945),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  item.icon,
                                  size: 28,
                                  color: const Color(0xFF1F140B),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Gilroy500',
                                  fontSize: 14,
                                  color: Color(0xFF1F140B),
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransitionDemoItem {
  final String title;
  final IconData icon;
  final PageRouteInfo destination;

  const _TransitionDemoItem({
    required this.title,
    required this.icon,
    required this.destination,
  });
}
