import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';
import 'package:poochcare/core/widgets/chips/app_chip.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/others/upload_image_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_state.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';

enum MyTipFormType { create, edit }

@RoutePage()
class MyTipGuideFormScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyTipGuideFormScreen({super.key, required this.type, this.tipId});

  final MyTipFormType type;
  final String? tipId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommunityStoreBloc>.value(
          value: getIt<CommunityStoreBloc>(),
        ),
        BlocProvider<CategoriesBloc>.value(value: getIt<CategoriesBloc>()),
        BlocProvider<TipsGuideBloc>.value(value: getIt<TipsGuideBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MyTipGuideFormScreen> createState() => _MyTipGuideFormScreenState();
}

class _MyTipGuideFormScreenState extends State<MyTipGuideFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  bool isSubmitting = false;
  String? selectedCategory;
  bool isAgreed = false;
  String tipStatus =
      'DRAFT'; // default to draft, can be changed to 'published' on submit
  List<File> localFiles = [];
  List<String> remoteFiles = [];

  /// =========================
  /// VALIDATION GETTERS
  /// =========================
  bool get isTitleValid => titleController.text.trim().isNotEmpty;

  bool get isSubmitEnabled =>
      isTitleValid && selectedCategory != null && isAgreed;

  bool get isDraftEnabled => isTitleValid;

  @override
  void initState() {
    super.initState();

    /// Rebuild on title change
    titleController.addListener(() {
      setState(() {});
    });

    /// 🔥 CALL API
    context.read<CategoriesBloc>().add(const FetchCategories());

    _prefillFromBloc();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _prefillFromBloc() {
    if (widget.type != MyTipFormType.edit) return;

    final state = context.read<TipsGuideBloc>().state;
    final item = state.selectedItem;

    if (item == null) return;
    titleController.text = item.title;
    descController.text = item.description;
    selectedCategory = item.categoryId;
    tipStatus = item.status;
    isAgreed =
        item.status !=
        'DRAFT'; // Only allow edit if it's draft, if published then show as read-only
    remoteFiles = List<String>.from(item.attachmentUrls);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: widget.type == MyTipFormType.create
          ? 'Add a new Tip/Info'
          : 'Edit a Tip/Info',
      child: SafeArea(
        child: Column(
          children: [
            /// =========================
            /// SCROLLABLE CONTENT
            /// =========================
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: AppSpacing.s16.h,
                  bottom: AppSpacing.s16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE + DESCRIPTION
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: Column(
                        children: [
                          AppTextField(
                            label: 'Add Tip/Info title',
                            controller: titleController,
                            isMandatory: true,
                            textInputAction: TextInputAction.next,
                          ),
                          AppSpacing.s20.hBox,

                          AppTextField(
                            floatingFontSize: AppFontSize.fs14,
                            isTextArea: true,
                            label: 'Add Description',
                            controller: descController,
                            height: 160.h,
                            textInputAction: TextInputAction.newline,
                            optionalText: 'Optional',
                            maxCount: 150,
                          ),
                        ],
                      ),
                    ),

                    AppSpacing.s40.hBox,

                    /// CATEGORY
                    const PrimaryWidgetHeader(title: 'Select Category'),

                    BlocBuilder<CategoriesBloc, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (state is CategoriesError) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(state.message),
                          );
                        }
                        return BlocBuilder<
                          CommunityStoreBloc,
                          CommunityStoreState
                        >(
                          builder: (context, storeState) {
                            final categories = storeState.categoryIds
                                .map((id) => storeState.categoriesById[id]!)
                                .toList();

                            if (categories.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No categories found'),
                              );
                            }

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.s16.w,
                              ),
                              child: Row(
                                children: categories.map((item) {
                                  final isSelected =
                                      selectedCategory == item.id;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: AppSpacing.s20.w,
                                    ),
                                    child: AppChip(
                                      label: item.name,
                                      isSelected: isSelected,
                                      onSelected: (_) {
                                        setState(() {
                                          selectedCategory = item.id;
                                        });
                                      },
                                      unselectedBgColor: AppColors.white,
                                      selectedBgColor: AppColors.white,
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    AppSpacing.s30.hBox,

                    /// UPLOAD
                    const PrimaryWidgetHeader(
                      title: 'Upload Images or Document',
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: UploadImageWidget(
                        buttonText: 'Upload',
                        customeSupport:
                            'Upload medical reports, prescriptions and vaccination certificates.',
                        maxSizeLabel: 'Max 2MB',
                        initialUrls: remoteFiles,
                        onFilesChanged: _onFilesChanged,
                        onRemoteChanged: _onRemoteChanged,
                      ),
                    ),

                    AppSpacing.s20.hBox,

                    /// TERMS
                    if (tipStatus == 'DRAFT') // Only show for create, not edit
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16.w,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCheckbox(
                              size: AppSize.cs24.csw,
                              value: isAgreed,
                              onChanged: (val) {
                                setState(() {
                                  isAgreed = val ?? false;
                                });
                              },
                              padding: EdgeInsets.zero,
                            ),
                            SizedBox(width: AppSpacing.s8.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'By submitting this tip, you agree to our ',
                                      style: AppTypography.support.copyWith(
                                        color: AppColors.black,
                                        fontSize: AppFontSize.fs10,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Terms & Conditions and Community Guidelines.',
                                      style: AppTypography.support.copyWith(
                                        color: AppColors.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: AppFontSize.fs10,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // handle navigation
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: AppSpacing.s20.h),
                  ],
                ),
              ),
            ),

            /// =========================
            /// FIXED BOTTOM BUTTONS
            /// =========================
            SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16.w,
                  vertical: AppSpacing.s16.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// SUBMIT
                    AppButton(
                      isLoading: isSubmitting,
                      label: 'Submit',
                      onPressed: isSubmitEnabled
                          ? () => _createTip(false)
                          : null,
                      isDisabled: !isSubmitEnabled,
                    ),

                    SizedBox(height: AppSpacing.s10.h),

                    /// SAVE AS DRAFT
                    AppButton(
                      isLoading: isSubmitting,
                      variant: AppButtonVariant.outlined,
                      label: 'Save as Draft',
                      onPressed: isDraftEnabled ? () => _createTip(true) : null,
                      isDisabled: !isDraftEnabled,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFilesChanged(List<File> files) {
    setState(() {
      localFiles = files;
    });
  }

  void _onRemoteChanged(List<String> urls) {
    setState(() {
      remoteFiles = urls;
    });
  }

  Future<List<Map<String, dynamic>>> _uploadAttachments() async {
    final uploadService = getIt<DocumentUploadService>();

    final uploadedFilesByPath = <String, UploadedDocumentFile>{};

    final result = await uploadService.processPendingUploadsForSave(
      context: context,
      ownerId: 'tip',
      entityType: UploadEntityType.community,
      purpose: UploadPurpose.otherDocuments,
      selectedFiles: localFiles,
      uploadedFilesByPath: uploadedFilesByPath,
      enableRetryForFailed: false, // 👈 keeps it simple
    );

    if (!result.shouldProceedWithSave) {
      throw Exception('Upload failed');
    }

    return uploadService.buildUploadedDocumentEntries(
      selectedFiles: localFiles,
      uploadedFilesByPath: uploadedFilesByPath,
    );
  }

  Future<void> _createTip(bool isDraft) async {
    log('Creating tip with title: ${titleController.text.trim()}');
    setState(() {
      isSubmitting = true;
    });

    final attachmentUrls = await _uploadAttachments();

    log('Attachment URLs: $attachmentUrls');

    // final List<String> newUrls = (attachmentUrls as List)
    //     .map((e) => e['url'].toString())
    //     .toList();

    try {
      // final List<String> urls = [
      //   ...remoteFiles, // remaining existing ones
      //   ...newUrls, // newly uploaded ones
      // ];
      // ignore: unused_local_variable
      final List<dynamic> urls = [
        ...remoteFiles, // remaining existing ones
        ...attachmentUrls, // newly uploaded ones
      ];

      if (!mounted) return; // ✅ I

      if (widget.type == MyTipFormType.edit) {
        await context.read<TipsGuideBloc>().updateTipGuide(
          tipId: widget.tipId!,
          categoryId: selectedCategory!,
          title: titleController.text.trim(),
          description: descController.text.trim(),
          isDraft: isDraft,
          attachmentUrls: urls,
        );
      } else {
        await context.read<TipsGuideBloc>().createTipGuide(
          categoryId: selectedCategory!,
          title: titleController.text.trim(),
          description: descController.text.trim(),
          isDraft: isDraft,
          attachmentUrls: urls,
        );
      }

      if (!mounted) return; // ✅ I
      AppDialog.show(
        icon: Lottie.asset(AppIcons.lottie.successful, repeat: false),
        context: context,
        title: isDraft ? 'Tip Saved as Draft' : 'Tip Submitted Successfully!',
        content: isDraft
            ? 'Your Tip has been saved as a draft and will be reviewed when you choose to submit it.'
            : 'Your Tip will be reviewed by our team and published to the community once approved.',
        primaryLabel: 'Done',
        secondaryLabel: 'Close',
        onPrimary: () async {
          Navigator.of(context).pop();
          return true;
        },
        onSecondary: () async {
          Navigator.of(context).pop();
          return true;
        },
      );
    } catch (e) {
      if (!mounted) return; // ✅ I
      AppDialog.show(
        icon: Lottie.asset(AppIcons.lottie.successful, repeat: false),
        context: context,
        title: 'Oops! There was an error.',
        content:
            'Your post was not saved successfully. Please retry posting again.',
        primaryLabel: 'Try Again',
        secondaryLabel: 'Later',
        onPrimary: () async {
          // Navigator.of(context).pop();
          _createTip(isDraft);
          return true;
        },
        onSecondary: () async {
          // Navigator.of(context).pop();
          return true;
        },
      );
      setState(() {
        isSubmitting = false;
      });
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }
}
