import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_filter_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/list_items/clinic_list_item_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_request_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_response_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class ClinicsListingScreen extends StatefulWidget {
  final String? selectedSpecialist;
  final ClinicType clinicType;
  final String? appBarTitle;
  const ClinicsListingScreen({
    super.key,
    this.clinicType = ClinicType.normal,
    this.selectedSpecialist,
    this.appBarTitle,
  });

  @override
  State<ClinicsListingScreen> createState() => _ClinicsListingScreenState();
}

class _ClinicsListingScreenState extends State<ClinicsListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ClinicListPaginationModel? _paginationData;
  late ClinicListRequestModel _activeRequest;
  bool _isLoadingMore = false;
  bool isSortingApplied = false;
  bool isFilterApplied = false;
  List<String> _selectedLocations = [];
  List<String> _selectedSpecializations = [];
  List<String> _selectedYearsOfExp = [];
  List<String> _selectedPriceRange = [];

  @override
  void initState() {
    super.initState();
    _activeRequest = ClinicListRequestModel(
      specializations: widget.selectedSpecialist != null
          ? [widget.selectedSpecialist ?? '']
          : null,
    );
    _fetchFirstPage();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoadingMore) return;

    final position = _scrollController.position;
    if (position.maxScrollExtent <= 0) return;

    // When remaining scroll is small, request next page.
    if (position.extentAfter < 300) {
      _fetchNextPage();
    }
  }

  void _fetchFirstPage() {
    _paginationData = null;
    context.read<ClinicBloc>().add(
      FetchClinicsEvent(
        clinicListRequestModel: _activeRequest,
        clinicType: widget.clinicType,
      ),
    );
  }

  void _fetchNextPage() {
    final pagination = _paginationData;
    if (pagination == null) return;
    if (pagination.page >= pagination.pages) return;

    setState(() {
      _isLoadingMore = true;
    });

    final nextPage = pagination.page + 1;
    final request = ClinicListRequestModel(
      city: _activeRequest.city,
      search: _activeRequest.search,
      specializations: _activeRequest.specializations,
      symptoms: _activeRequest.symptoms,
      yearsOfService: _activeRequest.yearsOfService,
      priceRange: _activeRequest.priceRange,
      sort: _activeRequest.sort,
      page: nextPage,
      limit: _activeRequest.limit,
    );

    context.read<ClinicBloc>().add(
      FetchClinicsEvent(
        clinicListRequestModel: request,
        clinicType: widget.clinicType,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Column(
            children: [
              PoochScreenAppBar(
                title: widget.appBarTitle ?? 'Book an In-Clinic Visit',
              ),
              const SizedBox(height: AppSpacing.s10),
              if (widget.clinicType == ClinicType.normal)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                  ),
                  child: AppSearchField(
                    controller: _searchController,
                    onChanged: (value) {
                      _activeRequest = ClinicListRequestModel(
                        city: _activeRequest.city,
                        search: value,
                        specializations: _activeRequest.specializations,
                        symptoms: _activeRequest.symptoms,
                        yearsOfService: _activeRequest.yearsOfService,
                        priceRange: _activeRequest.priceRange,
                        sort: _activeRequest.sort,
                      );
                      _fetchFirstPage();
                    },
                    onSubmitted: (value) {
                      _activeRequest = ClinicListRequestModel(
                        city: _activeRequest.city,
                        search: value,
                        specializations: _activeRequest.specializations,
                        symptoms: _activeRequest.symptoms,
                        yearsOfService: _activeRequest.yearsOfService,
                        priceRange: _activeRequest.priceRange,
                        sort: _activeRequest.sort,
                      );
                      _fetchFirstPage();
                    },
                  ),
                ),
              const SizedBox(height: AppSpacing.s10),
              if (widget.clinicType == ClinicType.normal) ...[
                sortingAndFilterRowWidget(),
                const SizedBox(height: AppSpacing.s10),
              ],
              Expanded(
                child: BlocConsumer<ClinicBloc, ClinicState>(
                  listener: (context, state) {
                    if (state.status == ClinicStatus.success) {
                      _paginationData = state.clinicsData?.pagination;

                      if (_isLoadingMore) {
                        setState(() {
                          _isLoadingMore = false;
                        });
                      }
                    }

                    if (state.status == ClinicStatus.failure &&
                        _isLoadingMore) {
                      setState(() {
                        _isLoadingMore = false;
                      });
                    }
                  },
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    final clinics = state.clinicsData?.clinics ?? [];
                    final parsedClinics = clinics.map((e) {
                      return ClinicListItemModel(
                        id: e.id,
                        clinicName: e.clinicName,
                        city: e.city,
                        image: e.clinicImage,
                        minConsultationFree:
                            'Starts @INR ${double.parse(e.minConsultationFee).formatPrice()}',
                        vetCount: e.vetCount,
                        years: e.years,
                        clinicId: e.id,
                        petId: '',
                        planId: '',
                        subscriptionId: '',
                      );
                    }).toList();

                    final showFullScreenLoader =
                        state.status == ClinicStatus.loading && clinics.isEmpty;
                    if (showFullScreenLoader) {
                      return const Center(child: CircularProgressIndicator());
                    } else if ((state.clinicsData?.clinics ?? []).isEmpty) {
                      return Center(
                        child: AppText.bodyS('No Clinics Available'),
                      );
                    } else if (state.status == ClinicStatus.failure) {
                      return Center(
                        child: AppText.bodyS('Something went wrong!'),
                      );
                    }

                    final showBottomLoader = _isLoadingMore;

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ClinicBloc>().add(
                          FetchClinicsEvent(
                            clinicListRequestModel: _activeRequest,
                            clinicType: widget.clinicType,
                          ),
                        );
                        await context.read<ClinicBloc>().stream.firstWhere(
                          (element) => element.status == ClinicStatus.success,
                        );
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                        ),
                        itemCount: showBottomLoader
                            ? parsedClinics.length + 1
                            : parsedClinics.length,
                        itemBuilder: (context, index) {
                          if (showBottomLoader &&
                              parsedClinics.length == index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSpacing.s16,
                              ),
                              child: SizedBox(
                                height: 48,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          final clinic = parsedClinics[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.s10,
                            ),
                            child: ClinicListItemCard(
                              clinic: clinic,
                              onTap: () {
                                context.router.push(
                                  ClinicDetailsRoute(clinicId: clinic.id),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<ClinicBloc, ClinicState> sortingAndFilterRowWidget() {
    return BlocConsumer<ClinicBloc, ClinicState>(
      listener: (context, state) {
        if (state.status == ClinicStatus.success) {
          if (_activeRequest.sort != null) {
            setState(() {
              isSortingApplied = true;
            });
          } else if (_activeRequest.sort == null) {
            setState(() {
              isSortingApplied = false;
            });
          }
        }
        if ((_activeRequest.specializations ?? []).isNotEmpty ||
            (_activeRequest.city ?? []).isNotEmpty ||
            (_activeRequest.yearsOfService ?? []).isNotEmpty ||
            (_activeRequest.priceRange ?? []).isNotEmpty) {
          setState(() {
            isFilterApplied = true;
          });
        } else if ((_activeRequest.specializations ?? []).isEmpty ||
            (_activeRequest.city ?? []).isEmpty ||
            (_activeRequest.yearsOfService ?? []).isEmpty ||
            (_activeRequest.priceRange ?? []).isEmpty) {
          setState(() {
            isFilterApplied = false;
          });
        }
      },
      builder: (context, state) {
        final clinicsData = state.clinicsData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SortingWidget(
                isSortingApplied: isSortingApplied,
                onSortingApplied: (value) {
                  _activeRequest = ClinicListRequestModel(
                    sort: value,
                    city: _activeRequest.city,
                    limit: _activeRequest.limit,
                    priceRange: _activeRequest.priceRange,
                    search: _activeRequest.search,
                    specializations: _activeRequest.specializations,
                    symptoms: _activeRequest.symptoms,
                    yearsOfService: _activeRequest.yearsOfService,
                  );
                  _fetchFirstPage();
                },
                clinicsData: clinicsData,
              ),
              ClinicFilterWidget(
                isFilterApplied: isFilterApplied,
                initialValues: {
                  'locations': _selectedLocations.toSet(),
                  'specializations': _selectedSpecializations.toSet(),
                  'yearsOfExperience': _selectedYearsOfExp.toSet(),
                  'priceRange': _selectedPriceRange.toSet(),
                },
                clinicsData: clinicsData,
                onFilterApplied: (value) {
                  onFilterApply(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onFilterApply(CustomFilterResult? value) {
    _selectedLocations = (value?.selectedValues['locations'] ?? {}).toList();
    _selectedSpecializations = (value?.selectedValues['specializations'] ?? {})
        .toList();
    _selectedPriceRange = (value?.selectedValues['priceRange'] ?? {}).toList();
    _selectedYearsOfExp = (value?.selectedValues['yearsOfExperience'] ?? {})
        .toList();
    _activeRequest = ClinicListRequestModel(
      specializations: _selectedSpecializations,
      priceRange: _selectedPriceRange,
      yearsOfService: _selectedYearsOfExp,
      city: _selectedLocations,
      search: _activeRequest.search,
      sort: _activeRequest.sort,
    );
    _fetchFirstPage();
  }
}

class ClinicFilterWidget extends StatelessWidget {
  final ClinicListResponseModel? clinicsData;
  final Map<String, Set<String>> initialValues;
  final bool isFilterApplied;
  final void Function(CustomFilterResult? value) onFilterApplied;
  const ClinicFilterWidget({
    required this.initialValues,
    required this.clinicsData,
    required this.onFilterApplied,
    required this.isFilterApplied,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final specializations =
        clinicsData?.availableFilters?.specializations ?? [];
    final locations = clinicsData?.availableFilters?.cities ?? [];
    final yearsOfExperience =
        clinicsData?.availableFilters?.yearsOfService ?? [];
    final priceRange = clinicsData?.availableFilters?.priceRange ?? [];
    return AppCircleButton(
      showShadow: false,
      onTap: () async {
        CustomFilterResult? data = await AppFilterDialog.show(
          context,
          initialSelectedValues: initialValues,
          sections: [
            FilterSectionItem(
              searchHint: 'Search Location',
              id: 'locations',
              title: 'Locations',
              enableSearch: true,
              selectionType: FilterSelectionType.multiple,
              options: List.generate(locations.length, (index) {
                final location = locations[index];
                return FilterOptionItem(id: location, label: location);
              }).toList(),
            ),
            FilterSectionItem(
              id: 'specializations',
              searchHint: 'Search Specializations',

              title: 'Specializations',
              enableSearch: true,
              selectionType: FilterSelectionType.multiple,
              options: List.generate(specializations.length, (index) {
                final specialization = specializations[index];
                return FilterOptionItem(
                  id: specialization,
                  label: specialization,
                );
              }).toList(),
            ),
            FilterSectionItem(
              searchHint: 'Search By Exp',

              id: 'yearsOfExperience',
              title: 'Years of experience',
              enableSearch: true,
              selectionType: FilterSelectionType.multiple,
              options: List.generate(yearsOfExperience.length, (index) {
                final experience = yearsOfExperience[index];
                return FilterOptionItem(
                  id: experience.value,
                  label: experience.label,
                );
              }).toList(),
            ),
            FilterSectionItem(
              searchHint: 'Search By Price',
              id: 'priceRange',
              title: 'Price Range',
              enableSearch: true,
              selectionType: FilterSelectionType.multiple,
              options: List.generate(priceRange.length, (index) {
                final price = priceRange[index];
                return FilterOptionItem(id: price.value, label: price.label);
              }).toList(),
            ),
          ],
        );
        onFilterApplied(data);
      },
      bgColor: AppColors.white,
      icon: AppIcons.svg.generic.filter,
      iconSize: 20,
    );
  }
}

class SortingWidget extends StatelessWidget {
  final void Function(String? value) onSortingApplied;
  final ClinicListResponseModel? clinicsData;
  final bool isSortingApplied;

  const SortingWidget({
    super.key,
    required this.onSortingApplied,
    required this.clinicsData,
    required this.isSortingApplied,
  });

  @override
  Widget build(BuildContext context) {
    final sortOptions = clinicsData?.availableFilters?.sortOptions ?? [];
    final totalClinics = (clinicsData?.clinics ?? []).length;
    return Badge(
      isLabelVisible: isSortingApplied,
      smallSize: 8,
      backgroundColor: AppColors.black,
      child: AppPopupMenu(
        onClose: () {
          onSortingApplied(null);
        },
        showCloseIcon: true,
        headerTitle: 'Sort By',
        items: List.generate(sortOptions.length, (index) {
          final lable = sortOptions[index].label;
          final sortOption = sortOptions[index].value;
          return AppPopupMenuItem(
            title: lable,
            onTap: () {
              if (totalClinics > 0) {
                onSortingApplied(sortOption);
              } else {
                CustomSnackbar.show(
                  'No clinics are available for sorting',
                  SnackbarType.warning,
                );
              }
            },
          );
        }),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white),
          ),
          child: AppIcon(AppIcons.svg.generic.sortDescending, size: 15),
        ),
      ),
    );
  }
}
