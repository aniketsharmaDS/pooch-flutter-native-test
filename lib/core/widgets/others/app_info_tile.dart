import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum AppInfoTileVariant { text, listing }

class AppInfoTileModel {
  final String id;
  final String title;
  final String description;
  final bool isExpandable;
  final AppInfoTileVariant variant;

  const AppInfoTileModel({
    required this.id,
    required this.title,
    required this.description,
    this.isExpandable = false,
    this.variant = AppInfoTileVariant.text,
  });
}

class AppInfoTile extends StatefulWidget {
  final AppInfoTileModel model;

  const AppInfoTile({super.key, required this.model});

  @override
  State<AppInfoTile> createState() => _AppInfoTileState();
}

class _AppInfoTileState extends State<AppInfoTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          AppText.h1(
            widget.model.title,
            color: const Color(0xFF260B01),
            fontSize: 14.sp,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.h),

          /// DESCRIPTION
          if (widget.model.variant == AppInfoTileVariant.listing)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.model.description
                  .split('\n')
                  .where((line) => line.trim().isNotEmpty)
                  .map(
                    (line) => Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.w, top: 2.h),
                            child: AppText.bodyS(
                              '•',
                              color: const Color(0xFF666667),
                              fontSize: 12.sp,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: AppText.bodyS(
                              line.trim(),
                              color: const Color(0xFF666667),
                              fontSize: 12.sp,
                              variant: AppTextVariant.noEllipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            )
          else if (!widget.model.isExpandable)
            AppText.bodyS(
              widget.model.description,
              color: const Color(0xFF666667),
              fontSize: 12.sp,
              variant: AppTextVariant.noEllipsis,
              style: const TextStyle(fontWeight: FontWeight.w400, height: 1.5),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodyS(
                  widget.model.description,
                  color: const Color(0xFF666667),
                  fontSize: 12.sp,
                  maxLines: _isExpanded ? null : 3,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: AppText.bodyS(
                    _isExpanded ? 'See Less' : 'See More',
                    color: const Color(0xFF260B01),
                    fontSize: 12.sp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
