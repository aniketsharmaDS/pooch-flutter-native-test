import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

@RoutePage()
class AppDesignScreen extends StatefulWidget {
  const AppDesignScreen({super.key});

  @override
  State<AppDesignScreen> createState() => AppDesignScreenState();
}

class AppDesignScreenState extends State<AppDesignScreen> {
  final TextEditingController _petNameController = TextEditingController(
    text: 'Sohail Shaikh',
  );
  final TextEditingController _readOnlyController = TextEditingController(
    text: '12/04/2026',
  );
  final TextEditingController _validPhoneController = TextEditingController(
    text: '+91 9876543210',
  );
  final TextEditingController _emailErrorController = TextEditingController(
    text: 'wrong-email-format',
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _disabledController = TextEditingController(
    text: 'Disabled input',
  );

  @override
  void dispose() {
    _petNameController.dispose();
    _readOnlyController.dispose();
    _validPhoneController.dispose();
    _emailErrorController.dispose();
    _passwordController.dispose();
    _notesController.dispose();
    _disabledController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildScreenHeader(),
              SizedBox(height: 18.h),
              _buildButtonShowcase(),
              SizedBox(height: 18.h),
              _buildTextShowcase(),
              SizedBox(height: 18.h),
              _buildTextFieldShowcase(context),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h2('Design System Showcase', color: const Color(0xFF260B01)),
          SizedBox(height: 6.h),
          AppText.bodyS(
            'Categorized examples for AppButton, AppText and AppTextField.',
            color: const Color(0xFF666667),
            variant: AppTextVariant.noEllipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h3(title, color: const Color(0xFF260B01)),
          SizedBox(height: 4.h),
          AppText.bodyS(
            subtitle,
            color: const Color(0xFF666667),
            variant: AppTextVariant.noEllipsis,
          ),
          SizedBox(height: 14.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCategoryTitle(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: AppText.bodyM(
        label,
        color: const Color(0xFF260B01),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildButtonShowcase() {
    return _buildSectionCard(
      title: 'App Button',
      subtitle: 'Variants, states, sizes, width behavior and styling options.',
      children: [
        _buildCategoryTitle('Variants'),
        AppButton(label: 'Filled', size: AppButtonSize.small, onPressed: () {}),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Outlined',
          size: AppButtonSize.small,
          variant: AppButtonVariant.outlined,
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Text',
          size: AppButtonSize.small,
          variant: AppButtonVariant.text,
          onPressed: () {},
        ),
        SizedBox(height: 18.h),
        _buildCategoryTitle('Sizes'),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            AppButton(
              label: 'xSmall',
              width: null,
              size: AppButtonSize.xSmall,
              onPressed: () {},
            ),
            AppButton(
              label: 'extraSmall',
              width: null,
              size: AppButtonSize.extraSmall,
              onPressed: () {},
            ),
            AppButton(
              label: 'small',
              width: null,
              size: AppButtonSize.small,
              onPressed: () {},
            ),
            AppButton(
              label: 'medium',
              width: null,
              size: AppButtonSize.medium,
              onPressed: () {},
            ),
            AppButton(label: 'large', width: null, onPressed: () {}),
          ],
        ),
        SizedBox(height: 18.h),
        _buildCategoryTitle('Width & Shape'),
        AppButton(
          label: 'Full Width (default)',
          size: AppButtonSize.small,
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 10.h,
          children: [
            AppButton(
              label: 'Wrap Content',
              width: null,
              size: AppButtonSize.small,
              onPressed: () {},
            ),
            AppButton(
              label: 'Custom Width',
              width: 180.w,
              size: AppButtonSize.small,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Pill',
                size: AppButtonSize.small,
                onPressed: () {},
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppButton(
                label: 'Rounded',
                size: AppButtonSize.small,
                isPill: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        _buildCategoryTitle('Icons'),
        AppButton(
          label: 'Leading Icon',
          size: AppButtonSize.small,
          leadingIcon: const Icon(Icons.pets_rounded),
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Trailing Icon',
          size: AppButtonSize.small,
          trailingIcon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Leading + Trailing',
          size: AppButtonSize.small,
          leadingIcon: const Icon(Icons.favorite_border_rounded),
          trailingIcon: const Icon(Icons.chevron_right_rounded),
          onPressed: () {},
        ),
        SizedBox(height: 18.h),
        _buildCategoryTitle('States'),
        AppButton(
          label: 'Loading State',
          size: AppButtonSize.small,
          isLoading: true,
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Disabled Filled',
          size: AppButtonSize.small,
          isDisabled: true,
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Disabled Outlined',
          size: AppButtonSize.small,
          variant: AppButtonVariant.outlined,
          isDisabled: true,
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        AppButton(
          label: 'Disabled Text',
          size: AppButtonSize.small,
          variant: AppButtonVariant.text,
          isDisabled: true,
          onPressed: () {},
        ),
        SizedBox(height: 18.h),
        _buildCategoryTitle('Custom Styling'),
        AppButton(
          label: 'Custom Colors',
          size: AppButtonSize.small,
          backgroundColor: const Color(0xFFF28A07),
          foregroundColor: Colors.white,
          onPressed: () {},
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            gradient: const LinearGradient(
              colors: [Color(0xFFAA3030), Color(0xFFF28A07)],
            ),
          ),
          child: AppButton(
            label: 'Glass Button',
            size: AppButtonSize.small,
            enableGlass: true,
            foregroundColor: Colors.white,
            borderColor: Colors.white.withValues(alpha: 0.55),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildTextShowcase() {
    return _buildSectionCard(
      title: 'App Text',
      subtitle: 'Typography variants from displayL to support.',
      children: [
        _buildTextSample('displayL', AppText.displayL('PoochCare')),
        _buildTextSample('displayM', AppText.displayM('PoochCare')),
        _buildTextSample('displayS', AppText.displayS('PoochCare')),
        _buildTextSample('h1', AppText.h1('PoochCare')),
        _buildTextSample('h2', AppText.h2('PoochCare')),
        _buildTextSample('h3', AppText.h3('PoochCare')),
        _buildTextSample('h4', AppText.h4('PoochCare')),
        _buildTextSample('bodyL', AppText.bodyL('PoochCare')),
        _buildTextSample('bodyM', AppText.bodyM('PoochCare')),
        _buildTextSample('bodyS', AppText.bodyS('PoochCare')),
        _buildTextSample('support', AppText.support('PoochCare')),
      ],
    );
  }

  Widget _buildTextSample(String label, Widget sample) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.support(
            label,
            color: const Color(0xFF666667),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h),
          sample,
        ],
      ),
    );
  }

  Widget _buildTextFieldShowcase(BuildContext context) {
    return _buildSectionCard(
      title: 'App TextField',
      subtitle:
          'Input styles covering basic, validated, textarea and disabled.',
      children: [
        _buildCategoryTitle('Basic + Mandatory'),
        AppTextField(
          label: 'Pet Name',
          hintText: 'Enter pet name',
          controller: _petNameController,
          isMandatory: true,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 14.h),
        _buildCategoryTitle('Read-only + Optional'),
        AppTextField(
          label: 'Appointment Date',
          controller: _readOnlyController,
          isReadOnly: true,
          optionalText: 'Optional',
          suffixWidget: const Icon(Icons.calendar_today_outlined, size: 18),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Read-only field tapped')),
            );
          },
        ),
        SizedBox(height: 14.h),
        _buildCategoryTitle('Validation States'),
        AppTextField(
          label: 'Phone Number',
          controller: _validPhoneController,
          keyboardType: TextInputType.phone,
          prefix: const Icon(Icons.phone_rounded, size: 18),
          suffixWidget: const Icon(
            Icons.check_circle_rounded,
            size: 18,
            color: Color(0xFF22C55E),
          ),
          isValidInput: true,
        ),
        SizedBox(height: 10.h),
        AppTextField(
          label: 'Email',
          hintText: 'name@example.com',
          controller: _emailErrorController,
          keyboardType: TextInputType.emailAddress,
          errorText: 'Please enter a valid email address.',
        ),
        SizedBox(height: 14.h),
        _buildCategoryTitle('Secure Input'),
        AppTextField(
          label: 'Password',
          hintText: 'Enter password',
          controller: _passwordController,
          obscureText: true,
        ),
        SizedBox(height: 14.h),
        _buildCategoryTitle('Text Area + Counter'),
        AppTextField(
          label: 'About Your Pet',
          hintText: 'Share health notes, behavior and food preferences...',
          controller: _notesController,
          isTextArea: true,
          height: 130,
          maxLines: 6,
          minLines: 4,
          maxCount: 180,
        ),
        SizedBox(height: 14.h),
        _buildCategoryTitle('Disabled'),
        AppTextField(
          label: 'Disabled Field',
          controller: _disabledController,
          enabled: false,
        ),
      ],
    );
  }
}
