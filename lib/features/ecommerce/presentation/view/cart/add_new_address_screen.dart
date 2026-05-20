import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/utils/app_extensions/string_capitalise_extension.dart';
import 'package:poochcare/core/utils/form_validators.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_phone_email_input_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_state.dart';

@RoutePage()
class AddNewAddressScreen extends StatefulWidget {
  final Address? address;

  const AddNewAddressScreen({this.address, super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late final TextEditingController _pincodeController;
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressLine1Controller;
  // late final TextEditingController _addressLine2Controller;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  double? latitude;
  double? longitude;
  String _countryCode = '91';
  late String _addressType;
  bool _forceValidate = false;
  bool _isLoading = false;
  String? selectedAddres;

  @override
  void initState() {
    super.initState();
    _pincodeController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressLine1Controller = TextEditingController();
    // _addressLine2Controller = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _emailController = TextEditingController();
    _addressType = widget.address?.addressType?.capitalize() ?? 'Home';

    // If editing, populate fields with existing address
    if (widget.address != null) {
      _populateFieldsFromAddress(widget.address!);
    }
  }

  void _populateFieldsFromAddress(Address address) {
    _pincodeController.text = address.pincode;
    _cityController.text = address.city;
    _stateController.text = address.emirate;
    _addressLine1Controller.text = address.addressLine;
    // _addressLine2Controller.text = address.addressDetails ?? '';
    _phoneController.text = address.residentPhone ?? '';
    _nameController.text = address.residentName ?? '';
    latitude = double.tryParse(address.latitude);
    longitude = double.tryParse(address.longitude);
    selectedAddres = address.addressDetails;
  }

  @override
  void dispose() {
    _pincodeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    // _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;

    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          ToastService.showSuccess(state.successMessage!);
          Navigator.pop(context);
        }
        if (state.errorMessage != null) {
          ToastService.showError(state.errorMessage!);
        }
      },
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PoochScreenAppBar(
                    title: isEditing ? 'Edit Address' : 'Add new address',
                  ),
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(
                      horizontal: AppSpacing.s16,
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Pincode',
                          isMandatory: true,
                          controller: _pincodeController,
                          keyboardType: TextInputType.number,
                          forceValidation: _forceValidate,
                          validator: (value) {
                            return FormValidators.validatePincode(value);
                          },
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        AppTextField(
                          label: 'Enter name',
                          isMandatory: true,
                          controller: _nameController,
                          forceValidation: _forceValidate,
                          validator: (value) {
                            return FormValidators.required(
                              value,
                              fieldName: 'Name',
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        AppPhoneEmailInputField(
                          phoneController: _phoneController,
                          onlyPhone: true,
                          countryCode: _countryCode,
                          onCountryCodeChanged: (value) {
                            _countryCode = value;
                          },
                          label: 'Enter Phone',
                          emailController: _emailController,
                        ),

                        const SizedBox(height: AppSpacing.s20),
                        Row(
                          children: [
                            AppText.h1(
                              'Type of address',
                              fontSize: AppFontSize.fs16,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s10),
                        Row(
                          children: [
                            _buildAddressTypeChip('Home'),
                            const SizedBox(width: AppSpacing.s7),
                            _buildAddressTypeChip('Office'),
                            const SizedBox(width: AppSpacing.s7),
                            _buildAddressTypeChip('Other'),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            selectAddress();
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 56,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                AppRadiusSize.r16,
                              ),
                            ),
                            child: AppText.h4(
                              selectedAddres == null
                                  ? 'Choose address'
                                  : selectedAddres ?? '',
                              style: AppTypography.inputLabel,
                              variant: AppTextVariant.noEllipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s20),

                        AppTextField(
                          label: 'Address',
                          isMandatory: true,
                          controller: _addressLine1Controller,
                          forceValidation: _forceValidate,
                          validator: (value) {
                            return FormValidators.required(
                              value,
                              fieldName: 'Address Line 1',
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        // AppTextField(
                        //   label: 'Address Line 2',
                        //   controller: _addressLine2Controller,
                        // ),
                        // const SizedBox(height: AppSpacing.s20),
                        AppTextField(
                          label: 'City',
                          isMandatory: true,
                          controller: _cityController,
                          forceValidation: _forceValidate,
                          validator: (value) {
                            return FormValidators.required(
                              value,
                              fieldName: 'City',
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        AppTextField(
                          label: 'State',
                          isMandatory: true,
                          controller: _stateController,
                          forceValidation: _forceValidate,
                          validator: (value) {
                            return FormValidators.required(
                              value,
                              fieldName: 'State',
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.s100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: AppSpacing.s10,
          ),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return AppButton(
                onPressed: _isLoading ? null : _validateAndSaveAddress,
                label: isEditing ? 'Update Address' : 'Save Address',
                size: AppButtonSize.medium,
                isLoading: _isLoading,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> selectAddress() async {
    final result = await AddressSearchBottomSheet.show(
      context: context,
      onSelectedApiCall: (place) async {
        setState(() {
          selectedAddres = place.description;
          latitude = place.latitude;
          longitude = place.longitude;
        });
        // addressController.text =
        //     place.description; // show selected address in the field
      },
    );

    if (result != null) {
      // print('Address-Returned to screen: ${result.description}');
    }
  }

  Widget _buildAddressTypeChip(String type) {
    final isSelected = _addressType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _addressType = type;
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(AppRadiusSize.r16),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
          ),
          child: AppText.h1(
            type,
            fontSize: AppFontSize.fs16,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  void _validateAndSaveAddress() {
    setState(() {
      _forceValidate = true;
    });

    final errorMessage = _validateMandatoryFields();
    if (selectedAddres == null || (selectedAddres ?? '').isEmpty) {
      CustomSnackbar.show('Address is required', SnackbarType.error);
      return;
    }
    if (errorMessage != null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final isEditing = widget.address != null;

    if (isEditing) {
      // Update address
      context.read<AddressBloc>().add(
        UpdateAddressEvent(
          addressId: widget.address!.id,
          addressLine: _addressLine1Controller.text.isEmpty
              ? ''
              : _addressLine1Controller.text,
          addressDetails: selectedAddres ?? '',
          pincode: _pincodeController.text,
          city: _cityController.text,
          emirate: _stateController.text,
          country: getCoutry(countryCode: _countryCode),
          latitude: latitude ?? 0,
          longitude: longitude ?? 0,
          isPrimary: widget.address!.isPrimary,
          addressType: _addressType.toLowerCase(),
          name: _nameController.text,
          phone: _phoneController.text,
        ),
      );
    } else {
      // Create new address
      context.read<AddressBloc>().add(
        CreateAddressEvent(
          addressType: _addressType.toLowerCase(),
          name: _nameController.text,
          phone: _phoneController.text,
          addressLine: _addressLine1Controller.text.isEmpty
              ? ''
              : _addressLine1Controller.text,
          addressDetails: selectedAddres ?? '',
          pincode: _pincodeController.text,
          city: _cityController.text,
          emirate: _stateController.text,
          country: getCoutry(countryCode: _countryCode),
          latitude: latitude ?? 0,
          longitude: longitude ?? 0,
        ),
      );
    }

    // Reset loading after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  String getCoutry({required String countryCode}) {
    switch (countryCode) {
      case '91':
        return 'India';
      case '971':
        return 'United Arab Emirates';
      default:
        return 'India';
    }
  }

  String? _validateMandatoryFields() {
    final validators = <String? Function()>[
      () => FormValidators.validatePincode(_pincodeController.text),
      () => FormValidators.required(_nameController.text, fieldName: 'Name'),
      () => FormValidators.phone(_phoneController.text),
      () => FormValidators.required(
        _addressLine1Controller.text,
        fieldName: 'Address Line 1',
      ),
      () => FormValidators.required(_cityController.text, fieldName: 'City'),
      () => FormValidators.required(_stateController.text, fieldName: 'State'),
    ];

    for (final validator in validators) {
      final error = validator();
      if (error != null) {
        return error;
      }
    }

    return null;
  }
}
