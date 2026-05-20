import 'dart:developer';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/transitions/transition_floating_animated_card.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_event.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_state.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/data/models/find_vet_form.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AppointmentTransitionScreen extends StatefulWidget {
  const AppointmentTransitionScreen({super.key});

  @override
  State<AppointmentTransitionScreen> createState() =>
      _AppointmentTransitionScreenState();
}

class _AppointmentTransitionScreenState
    extends State<AppointmentTransitionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _imageOpacity;
  bool _isSetupComplete = false;
  bool _hasScheduledSuccess = false;
  bool _hasHandledFailure = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _imageOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    final bookingData = getIt<AppointmentCubit>().bookingData;
    final FindVetForm? form = context.read<ClinicBloc>().state.findVetForm;
    Map<String, dynamic>? payload;
    if (form != null) {
      payload = FindVetFormMapper.toRequest(form);
    }

    context.read<AppointmentBloc>().add(
      BookAppointment(
        petId: bookingData.petId ?? '',
        clinicId: bookingData.clinicId ?? '',
        appointmentDate: bookingData.appointmentDate ?? '',
        appointmentTime: bookingData.appointmentTime ?? '',
        consultationType: bookingData.consultationType ?? 'video_call',
        chiefComplaint:
            (bookingData.chiefComplaint ?? bookingData.petNotes ?? '').trim(),
        priority: bookingData.priority ?? 'normal',
        durationMinutes: bookingData.durationMinutes ?? 30,
        findPayload: payload,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return BlocListener<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state.bookingStatus == AppointmentBookingStatus.success &&
            !_hasScheduledSuccess) {
          _hasScheduledSuccess = true;
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _isSetupComplete = true;
              });
              try {
                getIt<ClinicBloc>().add(const ResetFindVetForm());
              } catch (e) {
                log('Error resetting find vet form: $e');
              }
            }
          });
        }

        if (state.bookingStatus == AppointmentBookingStatus.failure &&
            !_hasHandledFailure) {
          _hasHandledFailure = true;
          context.router.replace(const SubsPaymentFailedTransitionRoute());
        }
      },
      child: _buildContent(context, bottomInset),
    );
  }

  Widget _buildContent(BuildContext context, double bottomInset) {
    // Show setup screen while waiting
    if (!_isSetupComplete) {
      return Scaffold(
        body: SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFEADBC8), Color(0xFFE6B75C)],
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppText.h4(
                    'Setting things\nup for your pet',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AppText.bodyL(
                    'Just a moment while we confirm\nwith the clinic.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF232324),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }

    // Show confirmed appointment content
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEADBC8), Color(0xFFE6B75C)],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppText.h4(
                    'Appointment\nConfirmed!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AppText.bodyL(
                    'Your booking was successful.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeTransition(
                          opacity: _imageOpacity,
                          child: Image.asset(
                            AppIcons.png.transitions.poochInsights,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            frameBuilder:
                                (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) {
                                  if (wasSynchronouslyLoaded || frame != null) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          if (mounted &&
                                              !_animationController
                                                  .isAnimating &&
                                              _animationController.value == 0) {
                                            _animationController.forward();
                                          }
                                        });
                                  }
                                  return child;
                                },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                color: Colors.black12,
                                alignment: Alignment.center,
                                child: const Text('Image placeholder'),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.9, -0.35),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: '',
                            position: const Alignment(0.9, -0.35),
                            slideFrom: SlideFrom.right,
                            delay: 200,
                            contentHeight: 35,
                            contentWidth: 35,
                            customContent: SvgPicture.asset(
                              AppIcons.svg.transitions.insightVet,
                            ),
                          ),
                          isActive: true,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-1.0, 0.24),
                        child: TransitionFloatingAnimatedCard(
                          data: FloatingCardData(
                            title: 'One step closer\nto better health',
                            position: const Alignment(-1.0, 0.24),
                            delay: 400,
                            customContent: const Icon(
                              Icons.health_and_safety,
                              color: Colors.orange,
                            ),
                          ),
                          isActive: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRect(
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(
                                  sigmaX: 2,
                                  sigmaY: 2,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                24,
                                0,
                                24,
                                20 + bottomInset,
                              ),
                              child: AppButton(
                                label: 'Continue',
                                enableGlass: true,
                                onPressed: () {
                                  context.read<ClinicBloc>().add(
                                    const ResetFindVetForm(),
                                  );
                                  context.router.popUntilRoot();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
